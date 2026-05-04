import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/timeline_item.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 150,
        horizontal: width < 720 ? 20 : 32,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.experience),
          const SizedBox(height: 80),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: const Column(
              children: [
                TimelineItem(
                  role: "Senior Flutter Architect",
                  company: "High-Tech Innovations",
                  duration: "2022 - Present",
                  description:
                      "Engineering scalable mobile architectures for complex enterprise systems. Specializing in real-time communication and custom UI ecosystems.",
                ),
                TimelineItem(
                  role: "Flutter Developer",
                  company: "Creative Labs",
                  duration: "2020 - 2022",
                  description:
                      "Built interactive educational and service-based applications with focus on animations and user experience.",
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
