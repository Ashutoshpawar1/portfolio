import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'controllers/app_cursor_controller.dart';
import 'controllers/home_controller.dart';
import 'routes/app_router.dart';
import 'theme/app_theme.dart';
import 'constants/app_strings.dart';
import 'utils/components/app_scroll_behavior.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Throttle visibility checks to 20ms to eliminate synchronous scroll stalls
  // while ensuring instant, lag-free scroll reveal animations.
  VisibilityDetectorController.instance.updateInterval = const Duration(
    milliseconds: 20,
  );

  // Inject global controllers
  Get.put(AppCursorController());
  Get.put(HomeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      scrollBehavior: const AppScrollBehavior(),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return Listener(
          onPointerDown: (event) {
            if (!Get.isRegistered<AppCursorController>()) return;
            if (event.kind == PointerDeviceKind.touch) {
              AppCursorController.to.markAsTouch();
            } else if (event.kind == PointerDeviceKind.mouse) {
              AppCursorController.to.markAsMouse();
              AppCursorController.to.setPressed(true);
            }
          },
          onPointerUp: (event) {
            if (Get.isRegistered<AppCursorController>()) {
              AppCursorController.to.setPressed(false);
            }
          },
          onPointerHover: (event) {
            if (!Get.isRegistered<AppCursorController>()) return;
            if (event.kind == PointerDeviceKind.mouse) {
              AppCursorController.to.markAsMouse();
              AppCursorController.to.updatePosition(event.position);
            }
          },
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
