import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/features/explore/views/explore_view.dart';
import 'package:<%= packageName %>/features/home/views/home_view.dart';
import 'package:<%= packageName %>/features/settings/views/settings_view.dart';
import 'package:<%= packageName %>/features/shell/controllers/main_shell_controller.dart';

class MainShellView extends GetView<MainShellController> {
  const MainShellView({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomeView(),
      ExploreView(),
      SettingsView(),
    ];

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.explore_outlined), label: 'Explore'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
