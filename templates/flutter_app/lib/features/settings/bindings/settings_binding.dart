import 'package:get/get.dart';
import 'package:<%= packageName %>/features/settings/controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SettingsController.new);
  }
}
