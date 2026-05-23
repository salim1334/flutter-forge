import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/common/layouts/page_wrapper.dart';
import 'package:<%= packageName %>/common/widgets/app_loader.dart';
import 'package:<%= packageName %>/common/widgets/empty_state.dart';
import 'package:<%= packageName %>/core/constants/app_enums.dart';
import 'package:<%= packageName %>/core/constants/app_texts.dart';
import 'package:<%= packageName %>/features/explore/controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: AppTexts.exploreTitle,
      child: Obx(() {
        switch (controller.loadingState.value) {
          case LoadingState.loading:
            return const AppLoader(message: 'Loading...');
          case LoadingState.error:
            return const EmptyState(message: 'Could not load items');
          case LoadingState.idle:
          case LoadingState.success:
            if (controller.items.isEmpty) {
              return const EmptyState(message: 'No items yet');
            }
            return RefreshIndicator(
              onRefresh: controller.reload,
              child: ListView.separated(
                itemCount: controller.items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.note_outlined),
                    title: Text(controller.items[index]),
                  );
                },
              ),
            );
        }
      }),
    );
  }
}
