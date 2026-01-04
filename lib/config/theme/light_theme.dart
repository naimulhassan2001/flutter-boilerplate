import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  useMaterial3: true,
  splashColor: AppColors.transparent,
  highlightColor: AppColors.transparent,
  hoverColor: AppColors.transparent,
  appBarTheme: const AppBarTheme(
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    backgroundColor: AppColors.background,
    centerTitle: true,
  ),
);
