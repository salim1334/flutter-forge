import 'package:flutter/material.dart';
import 'package:<%= packageName %>/core/constants/app_sizes.dart';

abstract final class ForgeBottomSheetTheme {
  static BottomSheetThemeData get light => const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.lg),
          ),
        ),
      );

  static BottomSheetThemeData get dark => const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppSizes.lg),
          ),
        ),
      );
}
