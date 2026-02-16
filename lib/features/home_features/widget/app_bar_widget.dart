import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makeupflutter/config/app_config/app_color/colors.dart';
import 'package:makeupflutter/config/app_config/app_font_styles/app_font_styles.dart';

AppBar customAppBar() {
  return AppBar(
    backgroundColor: Color(0xFFF5F5F0),
    title: Text(
      'ROSA',
      style: AppFontStyles().firstFontStyle(25.sp, primary2Color),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.shopping_bag, color: primary2Color, size: 21.sp),
      ),
    ],
  );
}
