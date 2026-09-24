import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/app_cursor_controller.dart';

/// Ultra-smooth, dual-layer custom cursor:
/// 1. Precision Dot: Instant zero-latency center point for pixel-perfect clicking.
/// 2. Fluid Follower Ring: Vsync-synchronized spring-lerp ring with interactive morphing.
class CustomCursorOverlay extends StatefulWidget {
  const CustomCursorOverlay({super.key});

  @override
  State<CustomCursorOverlay> createState() => _CustomCursorOverlayState();
}

class _CustomCursorOverlayState extends State<CustomCursorOverlay>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  Offset _followerPos = Offset.zero;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  void _onTick(Duration elapsed) {
    if (!mounted) return;
    if (!Get.isRegistered<AppCursorController>()) return;

    final controller = AppCursorController.to;
    if (controller.isTouchDevice.value) return;

    final target = controller.pointerPosition.value;
    if (!_initialized && target != Offset.zero) {
      _followerPos = target;
      _initialized = true;
      setState(() {});
      return;
    }

    // High refresh-rate smooth spring-lerp (0.22 factor provides fluid trailing with zero sluggishness)
    final double dx = lerpDouble(_followerPos.dx, target.dx, 0.22) ?? target.dx;
    final double dy = lerpDouble(_followerPos.dy, target.dy, 0.22) ?? target.dy;

    if ((_followerPos.dx - dx).abs() > 0.05 || (_followerPos.dy - dy).abs() > 0.05) {
      setState(() {
        _followerPos = Offset(dx, dy);
      });
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<AppCursorController>()) {
      return const SizedBox.shrink();
    }

    final controller = AppCursorController.to;

    return Obx(() {
      if (controller.isTouchDevice.value || !controller.isVisible.value) {
        return const SizedBox.shrink();
      }

      final isHovered = controller.isHovered.value;
      final isPressed = controller.isPressed.value;
      final cursorType = controller.cursorType.value;
      final hoverLabel = controller.hoverLabel.value;

      final double ringSize = isHovered
          ? (hoverLabel.isNotEmpty ? 68.0 : 54.0)
          : (cursorType == CursorType.text ? 28.0 : 36.0);
      final double ringScale = isPressed ? 0.82 : 1.0;

      return IgnorePointer(
        ignoring: true,
        child: RepaintBoundary(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Fluid Follower Ring
              Transform.translate(
                offset: Offset(
                  _followerPos.dx - (ringSize / 2),
                  _followerPos.dy - (ringSize / 2),
                ),
                child: AnimatedScale(
                  scale: ringScale,
                  duration: const Duration(milliseconds: 140),
                  curve: Curves.easeOutCubic,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    width: ringSize,
                    height: ringSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isHovered
                          ? const Color(0xFFFF5A36).withValues(alpha: 0.14)
                          : Colors.white.withValues(alpha: 0.04),
                      border: Border.all(
                        color: isHovered
                            ? const Color(0xFFFF5A36).withValues(alpha: 0.85)
                            : Colors.white.withValues(alpha: 0.45),
                        width: isHovered ? 1.8 : 1.2,
                      ),
                      boxShadow: isHovered
                          ? [
                              BoxShadow(
                                color: const Color(0xFFFF5A36).withValues(alpha: 0.28),
                                blurRadius: 18,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: hoverLabel.isNotEmpty
                        ? Text(
                            hoverLabel,
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          )
                        : null,
                  ),
                ),
              ),

              // Precision Center Dot (Instant Response)
              ValueListenableBuilder<Offset>(
                valueListenable: controller.pointerPosition,
                builder: (context, pos, _) {
                  final double dotSize = isHovered ? 4.0 : 6.5;
                  return Transform.translate(
                    offset: Offset(pos.dx - (dotSize / 2), pos.dy - (dotSize / 2)),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isHovered ? const Color(0xFFFF5A36) : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: (isHovered
                                    ? const Color(0xFFFF5A36)
                                    : Colors.white)
                                .withValues(alpha: 0.6),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
