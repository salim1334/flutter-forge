import 'package:flutter/material.dart';
import 'package:<%= packageName %>/core/constants/app_colors.dart';

abstract final class ForgeAppBarTheme {
  static AppBarTheme get light => const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.lightBackground,
        foregroundColor: Colors.black87,
      );

  static AppBarTheme get dark => const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.darkBackground,
        foregroundColor: Colors.white,
      );
}
