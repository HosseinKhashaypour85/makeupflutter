import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:makeupflutter/config/app_config/app_urls/app_assets_url.dart';
import 'package:makeupflutter/features/intro_features/screen/check_token_screen.dart';

import '../../../config/app_config/app_check_token/app_check_token.dart';
import '../../../config/app_config/app_color/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String screenId = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SplashPage.screenId,
        (route) => false,
      );
    });
    return Scaffold(
      backgroundColor: primary2Color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            FadeInUp(
              child: CircleAvatar(
                radius: 100.sp,
                backgroundColor: Colors.white,
                child: Image.asset(AppAssetsUrl.logoUrl),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 80.sp),
              child: SpinKitFadingCube(color: Colors.white, size: 30.sp),
            ),
          ],
        ),
      ),
    );
  }
}
