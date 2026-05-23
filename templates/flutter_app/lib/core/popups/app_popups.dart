import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:<%= packageName %>/core/constants/app_sizes.dart';

abstract final class AppPopups {
  static void showSuccessSnack(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      margin: const EdgeInsets.all(AppSizes.md),
    );
  }

  static void showErrorSnack(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      margin: const EdgeInsets.all(AppSizes.md),
    );
  }

  static void showInfoSnack(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(AppSizes.md),
    );
  }

  static Future<bool> showConfirmDialog({
    required String title,
    required String message,
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(result: false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Get.back(result: true), child: const Text('OK')),
        ],
      ),
    );
    return result ?? false;
  }

  static void showLoading([String message = 'Loading...']) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: AppSizes.md),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}
