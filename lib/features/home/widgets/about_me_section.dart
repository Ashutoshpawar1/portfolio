import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 32),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.aboutTitle),
          const SizedBox(height: 70),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Text(
              AppStrings.aboutContent,
              style: const TextStyle(
                fontSize: 22,
                color: AppColors.white,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 800))
          .slideY(begin: 0.1),
        ],
      ),
    );
  }
}
