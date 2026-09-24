import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CursorType {
  normal,
  interactive,
  text,
  hidden,
}

/// Global controller managing custom cursor position, hover states, and touch detection.
class AppCursorController extends GetxController {
  static AppCursorController get to => Get.find<AppCursorController>();

  // Immediate pointer position for zero-latency center point
  final ValueNotifier<Offset> pointerPosition = ValueNotifier(Offset.zero);

  // Reactive state for hover interactions
  final RxBool isHovered = false.obs;
  final RxBool isPressed = false.obs;
  final RxBool isVisible = false.obs;
  final RxBool isTouchDevice = false.obs;
  final Rx<CursorType> cursorType = CursorType.normal.obs;

  // Optional custom hover label (e.g., "VIEW", "EXPLORE", "PLAY")
  final RxString hoverLabel = "".obs;

  void updatePosition(Offset position) {
    if (isTouchDevice.value) return;
    pointerPosition.value = position;
    if (!isVisible.value) {
      isVisible.value = true;
    }
  }

  void setHovered(bool hovering, {CursorType type = CursorType.interactive, String? label}) {
    isHovered.value = hovering;
    cursorType.value = hovering ? type : CursorType.normal;
    hoverLabel.value = (hovering && label != null) ? label : "";
  }

  void setPressed(bool pressed) {
    isPressed.value = pressed;
  }

  void setVisible(bool visible) {
    isVisible.value = visible;
  }

  void markAsTouch() {
    isTouchDevice.value = true;
    isVisible.value = false;
  }

  void markAsMouse() {
    isTouchDevice.value = false;
  }

  @override
  void onClose() {
    pointerPosition.dispose();
    super.onClose();
  }
}
