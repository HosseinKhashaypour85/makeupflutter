import 'package:flutter/material.dart';


class AppFontStyles {
  TextStyle firstFontStyle(double fontSize , Color color){
    return TextStyle(fontFamily: 'kalameh', fontSize: fontSize, color: color);
  }
  TextStyle secondFontStyle(double fontSize , Color color){
    return TextStyle(fontFamily: 'peyda' , fontSize: fontSize , color: color);
  }
}