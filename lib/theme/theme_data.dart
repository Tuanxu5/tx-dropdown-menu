import 'package:flutter/material.dart';

class ColorData {
  static const Color colorPrimary = Color(0xFF1C252E);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorGrey = Color(0xFF637381);
  static const Color colorLight = Color(0xFFF4F6F8);
  static const Color colorWhite = Color(0xFFFFFFFF);
}

class StylesTextData {
  static TextStyle headerTextStyle = const TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w600,
    color: ColorData.colorPrimary,
  );
}
