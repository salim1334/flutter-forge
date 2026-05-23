import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/common/layouts/page_wrapper.dart';
import 'package:<%= packageName %>/core/constants/app_texts.dart';
import 'package:<%= packageName %>/features/settings/controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: AppTexts.settingsTitle,
      child: ListView(
        children: [
          const ListTile(
            title: Text('Theme'),
            subtitle: Text('Stored in SQLite via SettingsRepository'),
          ),
          Obx(
            () => SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(value: ThemeMode.system, label: Text('System')),
                ButtonSegment(value: ThemeMode.light, label: Text('Light')),
                ButtonSegment(value: ThemeMode.dark, label: Text('Dark')),
              ],
              selected: {controller.themeMode.value},
              onSelectionChanged: (modes) {
                controller.setTheme(modes.first);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear cache'),
            onTap: controller.clearCache,
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: controller.showAbout,
          ),
        ],
      ),
    );
  }
}
