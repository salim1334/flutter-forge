import 'package:get/get.dart';
import 'package:<%= packageName %>/core/utils/helpers/app_helper.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';

class SplashController extends GetxController {
  final SettingsRepository _settings = Get.find<SettingsRepository>();

  @override
  void onInit() {
    super.onInit();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final seenOnboarding = await _settings.hasSeenOnboarding();
    if (!seenOnboarding) {
      AppHelper.offAllNamed(AppRoutes.onboarding);
      return;
    }
    AppHelper.offAllNamed(AppRoutes.shell);
  }

  void skip() => _navigateNext();
}
