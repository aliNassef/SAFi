import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../../core/errors/failure.dart';
import '../logging/app_logger.dart';
import '../utils/app_constants.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth;

  // Cache verificationId for code verification
  String? _verificationId;

  FirebaseAuthService(this._auth);

  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: AppConstants.otpTimeout,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          AppLogger.info('✅ Verification completed automatically');
        },
        verificationFailed: (FirebaseAuthException e) {
          AppLogger.error('❌ Verification failed: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          AppLogger.info('📩 Code sent successfully');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
          AppLogger.info('⏰ Code auto-retrieval timeout');
        },
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      AppLogger.error('❌ Send OTP error: ${e.message}');
      return left(Failure(errMessage: e.message ?? 'Firebase Auth Error'));
    } catch (e) {
      AppLogger.error('❌ Send OTP error: $e');
      return left(Failure(errMessage: e.toString()));
    }
  }

  Future<Either<Failure, User>> verifyOtp({
    required String smsCode,
  }) async {
    try {
      if (_verificationId == null) {
        return left(
          const Failure(errMessage: 'Verification ID is null. Send OTP first.'),
        );
      }

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        AppLogger.info('✅ User signed in: ${user.phoneNumber}');
        return right(user);
      } else {
        return left(const Failure(errMessage: 'User is null'));
      }
    } on FirebaseAuthException catch (e) {
      AppLogger.error('❌ OTP verification failed: ${e.message}');
      return left(Failure(errMessage: e.message ?? 'Invalid OTP'));
    } catch (e) {
      AppLogger.error('❌ OTP verification error: $e');
      return left(Failure(errMessage: e.toString()));
    }
  }

  User? currentUser() => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
    AppLogger.info('⚡ User signed out');
  }
}
