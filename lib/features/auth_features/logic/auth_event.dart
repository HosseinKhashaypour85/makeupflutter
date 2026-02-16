part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CallAuthEventSendOtp extends AuthEvent {
  final String phoneNumber;

  CallAuthEventSendOtp({required this.phoneNumber});
}

class CallConfirmOtp extends AuthEvent {
  final String phoneNumber;
  final String otp;

  CallConfirmOtp({required this.phoneNumber, required this.otp});
}
