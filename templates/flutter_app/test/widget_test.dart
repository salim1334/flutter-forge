import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/app.dart';
import 'package:<%= packageName %>/core/constants/app_texts.dart';
import 'package:<%= packageName %>/features/splash/bindings/splash_binding.dart';
import 'package:<%= packageName %>/features/splash/views/splash_view.dart';
import 'helpers/test_setup.dart';

void main() {
  setUpAll(initForgeTestDatabase);

  setUp(() async {
    await setupForgeTest();
    SplashBinding().dependencies();
  });

  tearDown(tearDownForgeTest);

  testWidgets('Splash shows app name and welcome message', (tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(home: SplashView()),
    );
    await tester.pump();

    expect(find.text(AppTexts.appName), findsOneWidget);
    expect(find.text(AppTexts.welcomeMessage), findsOneWidget);
  });

  testWidgets('ForgeApp builds when dependencies are initialized', (tester) async {
    await tester.pumpWidget(const ForgeApp());
    await tester.pump();

    expect(find.text(AppTexts.appName), findsOneWidget);
  });
}
