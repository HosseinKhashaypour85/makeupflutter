import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../services/auth_api_services.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApiServices authApiServices;

  AuthBloc(this.authApiServices) : super(AuthInitial()) {
    on<CallAuthEventSendOtp>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final Response response = await authApiServices.callSendOtpApi(
          event.phoneNumber,
        );
        emit(AuthCompletedState(msg: response.data.toString()));
      } on DioException catch (e) {
        emit(AuthErrorState(msg: e.response!.data.toString()));
      } catch (e) {
        emit(AuthErrorState(msg: e.toString()));
      }
    });
    on<CallConfirmOtp>((event, emit) async {
      emit(AuthLoadingState());

      try {
        final Response response = await authApiServices.callConfirmOtpApi(
          event.phoneNumber,
          event.otp,
        );
        emit(AuthConfirmOtpCompletedState(msg: response.data.toString()));
      } on DioException catch (e) {
        emit(AuthErrorState(msg: e.response!.data.toString()));
      } catch (e) {
        emit(AuthErrorState(msg: e.toString()));
      }
    });
  }
}
