import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'app_cursor_controller.dart';

enum HomeSection {
  home,
  about,
  experience,
  projects,
  skills,
  tools,
  blog,
  github,
  contact,
}

/// Controller to manage Home Page state including menu visibility, parallax, and custom cursor.
class HomeController extends GetxController with GetTickerProviderStateMixin {
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
  final GlobalKey blogSectionKey = GlobalKey();
  final GlobalKey githubSectionKey = GlobalKey();
  final GlobalKey contactSectionKey = GlobalKey();

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
  Size? _lastViewportSize;
  int _lastParallaxUpdateMicros = 0;

  // Continuous physics-based momentum scroll state
  double? _smoothScrollTarget;
  Ticker? _smoothScrollTicker;

  HomeSection? _pendingSection;

  @override
  void onInit() {
    super.onInit();
    // Stop smooth scroll ticker when user drags manually
    scrollController.addListener(() {
      if (scrollController.hasClients &&
          scrollController.position.isScrollingNotifier.value &&
          scrollController.position.userScrollDirection !=
              ScrollDirection.idle &&
          _smoothScrollTarget == null) {
        _stopSmoothScrollTicker();
      }
    });
  }

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
    mousePos.value = pos;
    if (Get.isRegistered<AppCursorController>()) {
      AppCursorController.to.updatePosition(pos);
    }
  }

  void updateScroll(double offset) {
    if ((_scrollOffset.value - offset).abs() > 2) {
      _scrollOffset.value = offset;
    }
  }

  void updateParallax(Offset position, Size size) {
    _lastViewportSize = size;
    updateMousePos(position);

    final int now = DateTime.now().microsecondsSinceEpoch;
    if (now - _lastParallaxUpdateMicros < 16000) {
      return;
    }
    _lastParallaxUpdateMicros = now;

    final double nextParallaxX =
        (position.dx - size.width / 2) / (size.width / 2);
    final double nextParallaxY =
        (position.dy - size.height / 2) / (size.height / 2);

    if ((_parallaxX.value - nextParallaxX).abs() > 0.008) {
      _parallaxX.value = nextParallaxX;
    }
    if ((_parallaxY.value - nextParallaxY).abs() > 0.008) {
      _parallaxY.value = nextParallaxY;
    }
  }

  void resetParallax() {
    if (_parallaxX.value != 0.0) {
      _parallaxX.value = 0.0;
    }
    if (_parallaxY.value != 0.0) {
      _parallaxY.value = 0.0;
    }

    final Size? size = _lastViewportSize;
    if (size != null) {
      updateMousePos(Offset(size.width / 2, size.height / 2));
    }
  }

  /// Continuous physics-based momentum scroll engine.
  /// Works across both Web and Desktop with high-framerate exponential decay.
  void smoothScrollBy(double delta) {
    if (!scrollController.hasClients) {
      return;
    }

    final ScrollPosition position = scrollController.position;
    final double current = position.pixels;
    final double currentTarget = _smoothScrollTarget ?? current;
    final double nextTarget = (currentTarget + (delta * 1.05)).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    _smoothScrollTarget = nextTarget;
    _startSmoothScrollTicker();
  }

  void _startSmoothScrollTicker() {
    _smoothScrollTicker ??= createTicker((_) {
      if (!scrollController.hasClients || _smoothScrollTarget == null) {
        _stopSmoothScrollTicker();
        return;
      }

      final position = scrollController.position;
      final current = position.pixels;
      final target = _smoothScrollTarget!;
      final diff = target - current;

      if (diff.abs() < 0.6) {
        scrollController.jumpTo(target);
        _stopSmoothScrollTicker();
        return;
      }

      // 0.16 exponential decay factor yields liquid-smooth continuous gliding at 60/120fps
      final double step = diff * 0.16;
      final double next = (current + step).clamp(
        position.minScrollExtent,
        position.maxScrollExtent,
      );
      scrollController.jumpTo(next);
    });

    if (!_smoothScrollTicker!.isTicking) {
      _smoothScrollTicker!.start();
    }
  }

  void _stopSmoothScrollTicker() {
    _smoothScrollTarget = null;
    if (_smoothScrollTicker != null && _smoothScrollTicker!.isTicking) {
      _smoothScrollTicker!.stop();
    }
  }

  Future<void> navigateToSection(HomeSection section) async {
    _stopSmoothScrollTicker();
    final GlobalKey targetKey = switch (section) {
      HomeSection.about => aboutSectionKey,
      HomeSection.projects => projectsSectionKey,
      HomeSection.skills => skillsSectionKey,
      HomeSection.experience => experienceSectionKey,
      HomeSection.tools => toolsSectionKey,
      HomeSection.blog => blogSectionKey,
      HomeSection.github => githubSectionKey,
      HomeSection.contact => contactSectionKey,
      HomeSection.home => heroSectionKey,
    };

    final BuildContext? targetContext = targetKey.currentContext;
    if (targetContext != null) {
      await Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubicEmphasized,
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
    _stopSmoothScrollTicker();
    _smoothScrollTicker?.dispose();
    scrollController.dispose();
    mousePos.dispose();
    super.onClose();
  }
}
