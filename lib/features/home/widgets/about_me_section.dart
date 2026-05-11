import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 820;
    final bool isTablet = width >= 820 && width < 1180;
    final List<String> paragraphs = AppStrings.aboutContent.split('\n\n');

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 100 : 140,
        horizontal: isMobile ? 20 : (isTablet ? 36 : 56),
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.aboutTitle),
          SizedBox(height: isMobile ? 48 : 68),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: ScrollReveal(
              child: GlassContainer(
                padding: EdgeInsets.all(isMobile ? 24 : 36),
                borderRadius: 34,
                blur: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInUp(
                      duration: const Duration(milliseconds: 700),
                      from: 24,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: const Text(
                              "ABOUT",
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 76,
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.white.withOpacity(0.05),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: isMobile ? 28 : 34),
                    ...List.generate(paragraphs.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index == paragraphs.length - 1 ? 0 : 24,
                        ),
                        child: FadeInUp(
                          duration: Duration(milliseconds: 650 + (index * 120)),
                          from: 30,
                          child: Text(
                            paragraphs[index],
                            style: TextStyle(
                              fontSize: isMobile ? 17 : (isTablet ? 19 : 21),
                              color: AppColors.white.withOpacity(0.9),
                              height: 1.85,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: isMobile ? 30 : 42),
                    Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      children: const [
                        _AboutMetric(
                          endValue: 2,
                          suffix: '+',
                          label: 'Years of Flutter Experience',
                        ),
                        _AboutMetric(
                          endValue: 3,
                          suffix: '',
                          label: 'Languages Supported',
                        ),
                        _AboutMetric(
                          endValue: 100,
                          suffix: '%',
                          label: 'Responsive UI Focus',
                        ),
                      ],
                    ),
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

class _AboutMetric extends StatelessWidget {
  final int endValue;
  final String suffix;
  final String label;

  const _AboutMetric({
    required this.endValue,
    required this.suffix,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      from: 26,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.divider),
          color: Colors.white.withOpacity(0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: endValue.toDouble()),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Text(
                  '${value.round()}$suffix',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: AppColors.grey.withOpacity(0.92),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
