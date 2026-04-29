import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SkillProgressBar extends StatelessWidget {
  final String skill;
  final double progress;

  const SkillProgressBar({
    super.key,
    required this.skill,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: 10,
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(999),
                ),
              ).animate().shimmer(duration: 2.seconds, color: Colors.white24),
            ],
          ),
        ],
      ),
    );
  }
}
