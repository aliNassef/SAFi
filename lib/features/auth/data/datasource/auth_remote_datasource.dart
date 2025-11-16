import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/firebase_auth_service.dart';

abstract class AuthRemoteDatasource {
  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
  });

  Future<Either<Failure, User>> verifyOtp({
    required String otp,
  });

  User? getCurrentUser();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuthService _authService;

  AuthRemoteDatasourceImpl({required FirebaseAuthService authService})
    : _authService = authService;
  @override
  Future<Either<Failure, void>> sendOtp({
    required String phoneNumber,
  }) async => _authService.sendOtp(
    phoneNumber: phoneNumber,
  );

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String otp,
  }) async => _authService.verifyOtp(
    smsCode: otp,
  );

  @override
  User? getCurrentUser() => _authService.currentUser();
}
