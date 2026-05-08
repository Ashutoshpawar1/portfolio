import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum HomeSection { home, about, projects, skills, experience, tools }

/// Controller to manage Home Page state including menu visibility, parallax, and custom cursor.
class HomeController extends GetxController {
  // Observable state for menu overlay
  final _isMenuOpen = false.obs;
  bool get isMenuOpen => _isMenuOpen.value;
  final _isSectionTransitionVisible = false.obs;
  bool get isSectionTransitionVisible => _isSectionTransitionVisible.value;

  final ScrollController scrollController = ScrollController();
  final GlobalKey heroSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey projectsSectionKey = GlobalKey();
  final GlobalKey skillsSectionKey = GlobalKey();
  final GlobalKey experienceSectionKey = GlobalKey();
  final GlobalKey toolsSectionKey = GlobalKey();

  // Observable offsets for cursor-based parallax
  final _parallaxX = 0.0.obs;
  final _parallaxY = 0.0.obs;
  double get parallaxX => _parallaxX.value;
  double get parallaxY => _parallaxY.value;

  // Dedicated notifier for the custom cursor so pointer movement
  // doesn't trigger heavier GetX rebuild paths.
  final ValueNotifier<Offset> mousePos = ValueNotifier(Offset.zero);

  // Scroll offset for background/title effects
  final _scrollOffset = 0.0.obs;
  double get scrollOffset => _scrollOffset.value;

  HomeSection? _pendingSection;

  void toggleMenu() {
    _isMenuOpen.value = !_isMenuOpen.value;
  }

  void closeMenu() {
    _isMenuOpen.value = false;
  }

  Future<void> startSectionTransition(HomeSection section) async {
    closeMenu();
    _pendingSection = section;
    _isSectionTransitionVisible.value = true;
  }

  void updateMousePos(Offset pos) {
    if (mousePos.value != pos) {
      mousePos.value = pos;
    }
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

  Future<void> navigateToSection(HomeSection section) async {
    if (section == HomeSection.home) {
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
        );
      }
      return;
    }

    final GlobalKey targetKey = switch (section) {
      HomeSection.about => aboutSectionKey,
      HomeSection.projects => projectsSectionKey,
      HomeSection.skills => skillsSectionKey,
      HomeSection.experience => experienceSectionKey,
      HomeSection.tools => toolsSectionKey,
      HomeSection.home => heroSectionKey,
    };

    final BuildContext? targetContext = targetKey.currentContext;
    if (targetContext != null) {
      await Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 720),
        curve: Curves.easeOutCubic,
        alignment: 0.03,
      );
    }
  }

  Future<void> navigateToPendingSection() async {
    final HomeSection? target = _pendingSection;
    if (target == null) return;
    await navigateToSection(target);
  }

  void finishSectionTransition() {
    _pendingSection = null;
    _isSectionTransitionVisible.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    mousePos.dispose();
    super.onClose();
  }
}
