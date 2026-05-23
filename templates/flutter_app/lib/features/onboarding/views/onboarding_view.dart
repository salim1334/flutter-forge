import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/common/widgets/primary_button.dart';
import 'package:<%= packageName %>/features/onboarding/controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: controller.skip, child: const Text('Skip')),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(page.icon, size: 80),
                        const SizedBox(height: 24),
                        Text(page.title, style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 12),
                        Text(page.body, textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.pages.length,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentPage.value == i
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                label: 'Get started',
                onPressed: controller.finish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
