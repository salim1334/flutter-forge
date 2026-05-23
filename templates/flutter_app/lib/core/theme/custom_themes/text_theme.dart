import 'package:flutter/material.dart';

abstract final class ForgeTextTheme {
  static TextTheme get light => ThemeData.light().textTheme;
  static TextTheme get dark => ThemeData.dark().textTheme;
}
