import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Obx(
            () => Animate(
              effects: [
                SlideEffect(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                  duration: 800.ms,
                  curve: Curves.easeOutQuart,
                ),
                if (controller.isExiting)
                  SlideEffect(
                    begin: Offset.zero,
                    end: const Offset(0, -1),
                    duration: 800.ms,
                    curve: Curves.easeInQuart,
                  ),
              ],
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: AppColors.orange,
                child: Center(
                  child:
                      Text(
                            AppStrings.logoText,
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2,
                                ),
                          )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 600.ms)
                          .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
