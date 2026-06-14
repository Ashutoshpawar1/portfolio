import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.black,
      colorScheme: ColorScheme.dark(
        primary: AppColors.white,
        secondary: AppColors.emerald,
        surface: AppColors.surface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.oswald(
          fontSize: AppSizes.h1,
          fontWeight: FontWeight.w700,
          color: AppColors.white.withOpacity(0.1),
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.oswald(
          fontSize: AppSizes.h2,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
          height: 0.95,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: AppSizes.h3,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: AppSizes.body,
          color: AppColors.grey,
          height: 1.7,
        ),
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: AppSizes.caption,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
          letterSpacing: 1.8,
        ),
      ),
    );
  }
}
