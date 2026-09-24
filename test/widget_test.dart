import 'package:flutter_test/flutter_test.dart';
import 'package:ashu_portfolio/controllers/app_cursor_controller.dart';
import 'package:ashu_portfolio/controllers/home_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppCursorController Tests', () {
    late AppCursorController controller;

    setUp(() {
      controller = AppCursorController();
    });

    tearDown(() {
      controller.onClose();
    });

    test('Initializes with default values and is hidden until pointer moves', () {
      expect(controller.isVisible.value, isFalse);
      expect(controller.isHovered.value, isFalse);
      expect(controller.isPressed.value, isFalse);
      expect(controller.isTouchDevice.value, isFalse);
      expect(controller.cursorType.value, CursorType.normal);
    });

    test('updatePosition updates position and marks visible', () {
      controller.updatePosition(const Offset(100, 200));
      expect(controller.pointerPosition.value, const Offset(100, 200));
      expect(controller.isVisible.value, isTrue);
    });

    test('setHovered correctly changes hover state and label', () {
      controller.setHovered(true, type: CursorType.interactive, label: 'EXPLORE');
      expect(controller.isHovered.value, isTrue);
      expect(controller.cursorType.value, CursorType.interactive);
      expect(controller.hoverLabel.value, 'EXPLORE');

      controller.setHovered(false);
      expect(controller.isHovered.value, isFalse);
      expect(controller.cursorType.value, CursorType.normal);
      expect(controller.hoverLabel.value, '');
    });

    test('markAsTouch suppresses cursor for mobile devices', () {
      controller.updatePosition(const Offset(50, 50));
      expect(controller.isVisible.value, isTrue);

      controller.markAsTouch();
      expect(controller.isTouchDevice.value, isTrue);
      expect(controller.isVisible.value, isFalse);
    });
  });

  group('HomeController Smooth Scroll Tests', () {
    late HomeController homeController;

    setUp(() {
      homeController = HomeController();
    });

    tearDown(() {
      homeController.onClose();
    });

    test('Initial state of menu and parallax', () {
      expect(homeController.isMenuOpen, isFalse);
      expect(homeController.parallaxX, 0.0);
      expect(homeController.parallaxY, 0.0);
    });

    test('toggleMenu and closeMenu work properly', () {
      homeController.toggleMenu();
      expect(homeController.isMenuOpen, isTrue);
      homeController.closeMenu();
      expect(homeController.isMenuOpen, isFalse);
    });
  });
}
