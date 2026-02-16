import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makeupflutter/features/home_features/screen/home_screen.dart';
import 'package:makeupflutter/features/intro_features/screen/splash_screen.dart';
import 'package:makeupflutter/features/public_features/screen/bottom_nav_bar_screen.dart';

import '../logic/splash_cubit.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String screenId = "splashPage";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..checkToken(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is DeviceHaveToken) {
            Navigator.pushReplacementNamed(context, BottomNavBarScreen.screenId);
          } else if (state is DeviceHaveNotToken) {
            Navigator.pushReplacementNamed(context, 'auth');
          }
        },
        child: const SplashScreen(),
      ),
    );
  }
}
