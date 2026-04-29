import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../constants/app_colors.dart';

class AnimatedSectionTitle extends StatelessWidget {
  final String title;

  const AnimatedSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      return Transform.translate(
        offset: Offset(controller.scrollOffset * 0.1, 0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppColors.white.withOpacity(0.08),
            fontSize: 132,
            letterSpacing: -3,
          ),
        ),
      );
    });
  }
}
