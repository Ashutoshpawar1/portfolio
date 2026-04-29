import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TimelineItem extends StatelessWidget {
  final String company;
  final String role;
  final String duration;
  final String description;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.company,
    required this.role,
    required this.duration,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.18),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.white.withOpacity(0.14),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GlassContainer(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            role,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Text(
                          duration,
                          style: TextStyle(
                            color: AppColors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      company,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      description,
                      style: const TextStyle(
                        color: AppColors.grey,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().slideX(begin: 0.1, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}
