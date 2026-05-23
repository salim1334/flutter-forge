import 'package:get/get.dart';
import 'package:<%= packageName %>/features/explore/controllers/explore_controller.dart';
import 'package:<%= packageName %>/features/home/controllers/home_controller.dart';
import 'package:<%= packageName %>/features/settings/controllers/settings_controller.dart';
import 'package:<%= packageName %>/features/shell/controllers/main_shell_controller.dart';

class MainShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(MainShellController.new);
    Get.lazyPut(HomeController.new);
    Get.lazyPut(ExploreController.new);
    Get.lazyPut(SettingsController.new);
  }
}
