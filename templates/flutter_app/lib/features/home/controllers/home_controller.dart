import 'package:get/get.dart';
import 'package:<%= packageName %>/core/utils/helpers/app_helper.dart';
import 'package:<%= packageName %>/routes/app_routes.dart';

class HomeController extends GetxController {
  final RxInt counter = 0.obs;

  @override
  void onInit() {
    super.onInit();
    ever(counter, (_) {
      if (counter.value == 10) {
        AppHelper.showSnack('You reached 10 — nice persistence!');
      }
    });
  }

  void increment() => counter.value++;

  void goToExplore() => AppHelper.toNamed(AppRoutes.explore);
}
