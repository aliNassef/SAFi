import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/services/firebase_firestore_service.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/firebase_auth_service.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
  });

  Future<Either<Failure, User>> verifyOtpAndCreateUser({
    required String otp,
  });
  User? getCurrentUser();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuthService _authService;
  final FirebaseStoreService _db;
  AuthRemoteDatasourceImpl({
    required FirebaseAuthService authService,
    required FirebaseStoreService db,
  }) : _authService = authService,
       _db = db;
  @override
  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
  }) async => _authService.sendOtp(
    phoneNumber: phoneNumber,
  );

  @override
  Future<Either<Failure, User>> verifyOtpAndCreateUser({
    required String otp,
  }) async {
    final res = await _authService.verifyOtp(
      smsCode: otp,
    );
    res.fold(
      (failure) async {
        return left(failure);
      },
      (user) async {
        await _checkAndCreateUser(user);
        return right(user);
      },
    );
    return res;
  }

  @override
  User? getCurrentUser() => _authService.currentUser();

  Future<void> _checkAndCreateUser(User user) async {
    final doc = await _db.getUser(user.uid);

    if (!doc.exists) {
      await _db.createUser(
        userId: user.uid,
        name: user.displayName ?? '',
        phone: user.phoneNumber ?? '',
      );
    }
  }
}
