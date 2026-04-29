import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOutCubic,
        left: controller.mousePos.dx - 15,
        top: controller.mousePos.dy - 15,
        child: IgnorePointer(
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Center(child: FlutterLogo(size: 20))
                .animate(onPlay: (c) => c.repeat())
                .rotate(duration: const Duration(seconds: 2)),
          ),
        ),
      );
    });
  }
}
