import 'package:get/get.dart';
import 'package:<%= packageName %>/core/network/network_manager.dart';
import 'package:<%= packageName %>/core/utils/logging/app_logger.dart';
import 'package:<%= packageName %>/data/local/database_helper.dart';
import 'package:<%= packageName %>/data/repositories/settings_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppLogger(), permanent: true);
    Get.put(DatabaseHelper.instance, permanent: true);
    if (!Get.isRegistered<SettingsRepository>()) {
      Get.put(SettingsRepository(), permanent: true);
    }
    Get.put(NetworkManager(), permanent: true);
  }
}
