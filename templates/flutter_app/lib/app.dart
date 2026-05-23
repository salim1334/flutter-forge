import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/bindings/initial_bindings.dart';
import 'package:<%= packageName %>/core/theme/app_theme.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';
import 'package:<%= packageName %>/routes/app_pages.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';

class ForgeApp extends StatelessWidget {
  const ForgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsRepository>();

    return Obx(
      () => GetMaterialApp(
        title: '<%= projectName %>',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: settings.themeMode.value,
        initialRoute: AppRoutes.splash,
        getPages: AppPages.pages,
        initialBinding: InitialBindings(),
        defaultTransition: Transition.fadeIn,
        unknownRoute: GetPage(
          name: AppRoutes.notFound,
          page: () => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        ),
      ),
    );
  }
}
