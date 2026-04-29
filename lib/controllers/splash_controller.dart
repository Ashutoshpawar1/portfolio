import 'package:get/get.dart';
import '../routes/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class SplashController extends GetxController {
  final _isExiting = false.obs;
  bool get isExiting => _isExiting.value;

  @override
  void onInit() {
    super.onInit();
    _startExitTimer();
  }

  void _startExitTimer() async {
    await Future.delayed(const Duration(seconds: 2));
    _isExiting.value = true;
    await Future.delayed(const Duration(milliseconds: 800));
    // Since we are using GoRouter, we need context to navigate.
    // However, for GetX consistency, we can use Get.context if available.
    if (Get.context != null) {
      Get.context!.go(AppRouter.home);
    } else {
      // Fallback for web/debug if context is late
      AppRouter.router.go(AppRouter.home);
    }
  }
}
