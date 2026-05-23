import 'package:get/get.dart';
import 'package:<%= packageName %>/features/explore/bindings/explore_binding.dart';
import 'package:<%= packageName %>/features/explore/views/explore_view.dart';
import 'package:<%= packageName %>/features/home/bindings/home_binding.dart';
import 'package:<%= packageName %>/features/home/views/home_view.dart';
import 'package:<%= packageName %>/features/onboarding/bindings/onboarding_binding.dart';
import 'package:<%= packageName %>/features/onboarding/views/onboarding_view.dart';
import 'package:<%= packageName %>/features/settings/bindings/settings_binding.dart';
import 'package:<%= packageName %>/features/settings/views/settings_view.dart';
import 'package:<%= packageName %>/features/shell/bindings/main_shell_binding.dart';
import 'package:<%= packageName %>/features/shell/views/main_shell_view.dart';
import 'package:<%= packageName %>/features/splash/bindings/splash_binding.dart';
import 'package:<%= packageName %>/features/splash/views/splash_view.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';
// FORGE:IMPORTS

abstract final class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.shell,
      page: () => const MainShellView(),
      binding: MainShellBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.explore,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    // FORGE:PAGES
  ];
}
