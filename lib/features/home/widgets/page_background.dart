import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/home_controller.dart';

class PageBackground extends StatelessWidget {
  final bool enableMotion;

  const PageBackground({super.key, this.enableMotion = true});

  @override
  Widget build(BuildContext context) {
    if (!enableMotion) {
      return const _StaticPageBackground();
    }

    final controller = Get.find<HomeController>();

    return Obx(() {
      final double scrollShift = controller.scrollOffset * 0.05;
      final double parallaxX = controller.parallaxX * 18;
      final double parallaxY = controller.parallaxY * 18;

      return DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF090909), Color(0xFF030303)],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -210 + parallaxY,
              left: -140 + parallaxX,
              child: _GlowOrb(
                size: 520,
                color: Colors.white.withOpacity(0.025),
              ),
            ),
            Positioned(
              top: 120 + scrollShift,
              right: 160 - parallaxX,
              child: _GlowOrb(
                size: 240,
                color: const Color(0xFFFF7A59).withOpacity(0.05),
              ),
            ),
            Positioned(
              left: 260 - parallaxX,
              bottom: 180 - scrollShift,
              child: _GlowOrb(
                size: 320,
                color: const Color(0xFF4F46E5).withOpacity(0.04),
              ),
            ),
            Positioned(
              right: -90,
              bottom: 140 + parallaxY,
              child: _GlowOrb(
                size: 300,
                color: Colors.white.withOpacity(0.02),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _StaticPageBackground extends StatelessWidget {
  const _StaticPageBackground();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF090909), Color(0xFF030303)],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -210,
            left: -140,
            child: _GlowOrb(
              size: 520,
              color: Colors.white.withValues(alpha: 0.025),
            ),
          ),
          Positioned(
            top: 120,
            right: 160,
            child: _GlowOrb(
              size: 240,
              color: const Color(0xFFFF7A59).withValues(alpha: 0.05),
            ),
          ),
          Positioned(
            left: 260,
            bottom: 180,
            child: _GlowOrb(
              size: 320,
              color: const Color(0xFF4F46E5).withValues(alpha: 0.04),
            ),
          ),
          Positioned(
            right: -90,
            bottom: 140,
            child: _GlowOrb(
              size: 300,
              color: Colors.white.withValues(alpha: 0.02),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _GlowOrb({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}
