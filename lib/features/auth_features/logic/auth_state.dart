part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthCompletedState extends AuthState {
  final String msg;

  AuthCompletedState({required this.msg});
}

class AuthErrorState extends AuthState {
  final String msg;

  AuthErrorState({required this.msg});
}

class AuthConfirmOtpLoadingState extends AuthState {}

class AuthConfirmOtpCompletedState extends AuthState {
  final String msg;
  AuthConfirmOtpCompletedState({required this.msg});
}

class AuthConfirmOtpErrorState extends AuthState {}
