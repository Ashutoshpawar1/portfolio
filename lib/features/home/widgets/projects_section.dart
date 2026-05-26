import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/project_card.dart';
import '../../../utils/components/scroll_reveal.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 820;
    final double carouselHeight = width < 440 ? 560 : (isMobile ? 590 : 600);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 130,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.projectsTitle),
          const SizedBox(height: 28),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            from: 20,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                'A curated collection of production-level Flutter applications focused on scalability, architecture, performance, and polished user experiences.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: isMobile ? 16 : 18,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
          ScrollReveal(
            child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: appProjects.length,
                  itemBuilder: (context, index, realIndex) {
                    final project = appProjects[index];
                    return ProjectCard(project: project);
                  },
                  options: CarouselOptions(
                    height: carouselHeight,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(
                      milliseconds: 900,
                    ),
                    autoPlayCurve: Curves.easeOutCubic,
                    viewportFraction: width < 720
                        ? 0.9
                        : (width < 1180 ? 0.62 : 0.38),
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) {
                      if (_activeIndex != index) {
                        setState(() => _activeIndex = index);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: List.generate(appProjects.length, (index) {
                    final bool isActive = index == _activeIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      width: isActive ? 34 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(999),
                        color: isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.18),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
