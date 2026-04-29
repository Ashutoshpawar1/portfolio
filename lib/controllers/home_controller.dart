import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// Controller to manage Home Page state including menu visibility, parallax, and custom cursor.
class HomeController extends GetxController {
  // Observable state for menu overlay
  final _isMenuOpen = false.obs;
  bool get isMenuOpen => _isMenuOpen.value;

  // Observable offsets for cursor-based parallax
  final _parallaxX = 0.0.obs;
  final _parallaxY = 0.0.obs;
  double get parallaxX => _parallaxX.value;
  double get parallaxY => _parallaxY.value;

  // Global mouse position for custom cursor
  final _mousePos = Offset.zero.obs;
  Offset get mousePos => _mousePos.value;

  // Scroll offset for background/title effects
  final _scrollOffset = 0.0.obs;
  double get scrollOffset => _scrollOffset.value;

  void toggleMenu() {
    _isMenuOpen.value = !_isMenuOpen.value;
  }

  void updateMousePos(Offset pos) {
    _mousePos.value = pos;
  }

  void updateScroll(double offset) {
    _scrollOffset.value = offset;
  }

  void updateParallax(Offset position, Size size) {
    _parallaxX.value = (position.dx - size.width / 2) / (size.width / 2);
    _parallaxY.value = (position.dy - size.height / 2) / (size.height / 2);
    updateMousePos(position);
  }

  void resetParallax() {
    _parallaxX.value = 0.0;
    _parallaxY.value = 0.0;
  }
}
