import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle get title => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    fontFamily: 'Roboto',
  );

  static TextStyle get body => TextStyle(
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  static TextStyle get placeholder => TextStyle(
    fontSize: 15,
    color: AppColors.placeholder,
  );

  static TextStyle get button => TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get cookieText => TextStyle(
    fontSize: 11,
    color: AppColors.textSecondary,
  );

  static TextStyle get cookieButton => TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );
}