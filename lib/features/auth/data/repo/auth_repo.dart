import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failure.dart';
import '../datasource/auth_remote_datasource.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> signInWithPhoneNumber({
    required String phoneNumber,
  });

  Future<Either<Failure, User>> verifyOtp({
    required String otp,
  });

  Future<Either<Failure, void>> logout();

  User? getCurrentUser();
}

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepoImpl({required AuthRemoteDatasource authRemoteDatasource})
    : _authRemoteDatasource = authRemoteDatasource;
  @override
  Future<Either<Failure, void>> signInWithPhoneNumber({
    required String phoneNumber,
  }) async {
    return await _authRemoteDatasource.sendOtp(
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<Either<Failure, User>> verifyOtp({
    required String otp,
  }) async {
    return await _authRemoteDatasource.verifyOtpAndCreateUser(
      otp: otp,
    );
  }

  @override
  User? getCurrentUser() => _authRemoteDatasource.getCurrentUser();

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authRemoteDatasource.logout();
      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
