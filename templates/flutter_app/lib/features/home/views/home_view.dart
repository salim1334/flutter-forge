import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/common/layouts/page_wrapper.dart';
import 'package:<%= packageName %>/common/widgets/primary_button.dart';
import 'package:<%= packageName %>/common/widgets/section_header.dart';
import 'package:<%= packageName %>/core/constants/app_texts.dart';
import 'package:<%= packageName %>/features/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: AppTexts.homeTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            title: 'GetX reactive demo',
            subtitle: 'Tap + to see Obx and ever() in action.',
          ),
          const SizedBox(height: 24),
          Obx(
            () => Text(
              'Counter: ${controller.counter.value}',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: controller.increment,
            child: const Text('+1'),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: 'Open Explore (named route)',
            onPressed: controller.goToExplore,
          ),
        ],
      ),
    );
  }
}
