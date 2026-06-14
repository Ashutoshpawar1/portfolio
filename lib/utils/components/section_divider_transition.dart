import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class SectionDividerTransition extends StatefulWidget {
  final String label;
  final HomeSection nextSection;

  const SectionDividerTransition({
    super.key,
    required this.label,
    required this.nextSection,
  });

  @override
  State<SectionDividerTransition> createState() =>
      _SectionDividerTransitionState();
}

class _SectionDividerTransitionState extends State<SectionDividerTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => controller.navigateToSection(widget.nextSection),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          color: Colors.transparent, // Ensures entire region is tapable
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulse line
              Container(
                width: 1,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.01),
                      const Color(
                        0xFFFF5A36,
                      ).withOpacity(_isHovered ? 0.6 : 0.3),
                      Colors.white.withOpacity(0.01),
                    ],
                  ),
                ),
                child: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Align(
                      alignment: Alignment(
                        0.0,
                        -1.0 + (_pulseAnimation.value * 2.0),
                      ),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFF5A36),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFF5A36).withOpacity(0.8),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Downward Chevron and Next Title
              AnimatedScale(
                scale: _isHovered ? 1.05 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Text(
                  widget.label.toUpperCase(),
                  style: TextStyle(
                    color: _isHovered
                        ? const Color(0xFFFF5A36)
                        : Colors.white.withOpacity(0.35),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _isHovered
                        ? const Color(0xFFFF5A36)
                        : Colors.white.withOpacity(0.25),
                    size: 20,
                  )
                  .animate(onPlay: (c) => c.repeat())
                  .slideY(
                    begin: -0.2,
                    end: 0.2,
                    duration: 1200.ms,
                    curve: Curves.easeInOut,
                  )
                  .fadeIn(duration: 600.ms)
                  .then()
                  .fadeOut(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
