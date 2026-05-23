import 'package:flutter/material.dart';
import 'package:<%= packageName %>/core/constants/app_sizes.dart';

abstract final class ForgeInputTheme {
  static InputDecorationTheme get light => InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
      );

  static InputDecorationTheme get dark => InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
      );
}
