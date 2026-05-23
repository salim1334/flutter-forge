import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/core/constants/app_texts.dart';
import 'package:<%= packageName %>/core/utils/helpers/app_helper.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final SettingsRepository _settings = Get.find<SettingsRepository>();
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<({String title, String body, IconData icon})> pages = [
    (
      title: AppTexts.onboardingTitle,
      body: AppTexts.onboardingSubtitle,
      icon: Icons.architecture_outlined,
    ),
    (
      title: 'GetX ready',
      body: 'Controllers, bindings, and named routes are wired for you.',
      icon: Icons.hub_outlined,
    ),
    (
      title: 'SQLite included',
      body: 'Local settings and sample data persistence out of the box.',
      icon: Icons.storage_outlined,
    ),
  ];

  void onPageChanged(int index) => currentPage.value = index;

  Future<void> finish() async {
    await _settings.setOnboardingComplete();
    AppHelper.offAllNamed(AppRoutes.shell);
  }

  void skip() => finish();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
