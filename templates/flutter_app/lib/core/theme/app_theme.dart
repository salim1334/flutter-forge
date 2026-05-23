import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:<%= packageName %>/core/constants/app_colors.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/app_bar_theme.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/button_theme.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/chip_theme.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/input_theme.dart';
import 'package:<%= packageName %>/core/theme/custom_themes/text_theme.dart';

abstract final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: ForgeTextTheme.light,
      appBarTheme: ForgeAppBarTheme.light,
      elevatedButtonTheme: ForgeButtonTheme.light,
      inputDecorationTheme: ForgeInputTheme.light,
      chipTheme: ForgeChipTheme.light,
      bottomSheetTheme: ForgeBottomSheetTheme.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: ForgeTextTheme.dark,
      appBarTheme: ForgeAppBarTheme.dark,
      elevatedButtonTheme: ForgeButtonTheme.dark,
      inputDecorationTheme: ForgeInputTheme.dark,
      chipTheme: ForgeChipTheme.dark,
      bottomSheetTheme: ForgeBottomSheetTheme.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }
}
