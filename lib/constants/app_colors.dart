import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF050505);
  static const Color darkGrey = Color(0xFF111111);
  static const Color surface = Color(0xFF141414);
  static const Color surfaceElevated = Color(0xFF1B1B1B);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF9D9D9D);
  static const Color orange = Color(0xFFF1EEE8);
  static const Color emerald = Color(0xFF53D769);
  static const Color divider = Color(0x22FFFFFF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFF5F5F5), Color(0xFF767676)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyanGradient = LinearGradient(
    colors: [Color(0xFF262626), Color(0xFF080808)],
  );

  static const Color glassBorder = Color(0x26FFFFFF);
  static const Color glassBackground = Color(0x12FFFFFF);
}
