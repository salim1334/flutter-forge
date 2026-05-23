import 'package:get/get.dart';
import 'package:<%= packageName %>/features/onboarding/controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OnboardingController.new);
  }
}
