import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthFirstTime extends AuthState {}

class AuthCodeSent extends AuthState {}

class AuthFailure extends AuthState {
  final String errMessage;

  const AuthFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
