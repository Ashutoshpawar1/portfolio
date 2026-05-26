import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return IgnorePointer(
      child: ValueListenableBuilder<Offset>(
        valueListenable: controller.mousePos,
        child: RepaintBoundary(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: const Center(child: FlutterLogo(size: 20)),
          ),
        ),
        builder: (context, position, child) {
          return Transform.translate(
            offset: Offset(position.dx - 15, position.dy - 15),
            child: child,
          );
        },
      ),
    );
  }
}
