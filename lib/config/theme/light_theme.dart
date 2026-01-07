import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  useMaterial3: true,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  hoverColor: AppColors.transparent,

  /// AppBar Theme
  appBarTheme: const AppBarTheme(
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    backgroundColor: AppColors.background,
    centerTitle: true,
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      maximumSize: Size(double.infinity, 48.h),
      minimumSize: Size(double.infinity, 48.h),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
    ),
  ),

  /// Text Theme
  textTheme: TextTheme(
    bodySmall: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.black,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.black,
    ),
  ),
);
