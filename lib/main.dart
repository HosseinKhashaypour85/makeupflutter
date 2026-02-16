import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/features/auth_features/logic/auth_bloc.dart';
import 'package:makeupflutter/features/auth_features/screen/auth_screen.dart';
import 'package:makeupflutter/features/auth_features/screen/confirm_otp_screen.dart';
import 'package:makeupflutter/features/auth_features/services/auth_api_services.dart';
import 'package:makeupflutter/features/category_features/logic/category_bloc.dart';
import 'package:makeupflutter/features/category_features/services/category_api_repository.dart';
import 'package:makeupflutter/features/home_features/screen/home_screen.dart';
import 'package:makeupflutter/features/intro_features/logic/splash_cubit.dart';
import 'package:makeupflutter/features/intro_features/screen/check_token_screen.dart';
import 'package:makeupflutter/features/intro_features/screen/splash_screen.dart';
import 'package:makeupflutter/features/public_features/logic/bottom_nav_cubit.dart';
import 'package:makeupflutter/features/public_features/screen/bottom_nav_bar_screen.dart';

import 'features/category_features/screen/category_screen.dart';
import 'features/product_features/screen/all_products_screen.dart';

void main() {
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => BottomNavCubit()),
          BlocProvider(create: (context) => AuthBloc(AuthApiServices())),
          BlocProvider(create: (context) => SplashCubit()),
          BlocProvider(
            create: (context) => CategoryBloc(CategoryApiRepository()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('fa')],
          routes: {
            SplashScreen.screenId: (context) => SplashScreen(),
            AuthScreen.screenId: (context) => AuthScreen(),
            SplashPage.screenId: (context) => SplashPage(),
            ConfirmOtpScreen.screenId: (context) => ConfirmOtpScreen(),
            HomeScreen.screenId: (context) => HomeScreen(),
            BottomNavBarScreen.screenId: (context) => BottomNavBarScreen(),
            AllProductsScreen.screenId: (context) => AllProductsScreen(),
            CategoryScreen.screenId: (context) {
              final categoryId =
                  ModalRoute.of(context)!.settings.arguments as String;

              return CategoryScreen(categoryId: categoryId);
            },
          },
          initialRoute: BottomNavBarScreen.screenId,
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
