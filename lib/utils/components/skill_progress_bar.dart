import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillProgressBar extends StatelessWidget {
  final String skill;
  final double progress;
  final IconData icon;
  final Color? accentColor;

  const SkillProgressBar({
    super.key,
    required this.skill,
    required this.progress,
    required this.icon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        accentColor ?? const Color(0xFF6366F1); // Default purple-blue

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: effectiveColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                skill,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            Text(
              "${(progress * 100).toInt()}%",
              style: TextStyle(
                color: effectiveColor.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Stack(
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.easeOutQuart,
                      height: 6,
                      width: constraints.maxWidth * progress,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            effectiveColor.withOpacity(0.7),
                            effectiveColor,
                            effectiveColor.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: effectiveColor.withOpacity(0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(
                      duration: 2500.ms,
                      color: Colors.white.withOpacity(0.2),
                    );
              },
            ),
          ],
        ),
      ],
    );
  }
}
