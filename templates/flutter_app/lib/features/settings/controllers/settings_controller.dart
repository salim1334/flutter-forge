import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/core/popups/app_popups.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';

class SettingsController extends GetxController {
  final SettingsRepository _settings = Get.find<SettingsRepository>();

  Rx<ThemeMode> get themeMode => _settings.themeMode;

  Future<void> setTheme(ThemeMode mode) => _settings.setThemeMode(mode);

  Future<void> clearCache() async {
    final confirmed = await AppPopups.showConfirmDialog(
      title: 'Clear cache?',
      message: 'This resets onboarding and theme preferences.',
    );
    if (!confirmed) return;
    await _settings.clearCache();
    AppPopups.showSuccessSnack('Cache cleared');
  }

  void showAbout() {
    AppPopups.showInfoSnack('<%= projectName %> — forged with Flutter Forge');
  }
}
