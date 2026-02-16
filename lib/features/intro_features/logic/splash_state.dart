part of 'splash_cubit.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class DeviceHaveToken extends SplashState{}

class DeviceHaveNotToken extends SplashState{}