import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());

  final AuthRepo _authRepo;

  void signInWithphoneNumber({
    required String phoneNumber,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.signInWithPhoneNumber(
      phoneNumber: phoneNumber,
    );
    result.fold(
      (failure) => emit(AuthFailure(errMessage: failure.errMessage)),
      (_) => emit(AuthCodeSent()),
    );
  }

  void verifyOtp({required String otp}) async {
    emit(AuthLoading());
    final result = await _authRepo.verifyOtp(
      otp: otp,
    );
    result.fold(
      (failure) => emit(AuthFailure(errMessage: failure.errMessage)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  void checkAuthState() async {
    final user = _authRepo.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess(user: user));
    } else {
      emit(AuthFirstTime());
    }
  }

  User? getCurrentUser() {
    final user = _authRepo.getCurrentUser();
    return user;
  }
}
