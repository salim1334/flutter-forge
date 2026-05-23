import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/core/popups/app_popups.dart';

class NetworkManager extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((results) {
      final online = results.any((r) => r != ConnectivityResult.none);
      isOnline.value = online;
      if (!online) {
        AppPopups.showErrorSnack('No internet connection');
      }
    });
  }

  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    final online = results.any((r) => r != ConnectivityResult.none);
    isOnline.value = online;
    return online;
  }
}
