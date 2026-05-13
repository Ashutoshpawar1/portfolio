import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static const List<_ExperienceEntry> _entries = [
    _ExperienceEntry(
      role: "Flutter Developer",
      company: "Developer Bazar Technologies",
      duration: "Nov 2024 - Present",
      description:
          "Working on scalable Flutter applications involving real-time systems, API integrations, responsive UI engineering, and production deployment workflows.",
    ),
    _ExperienceEntry(
      role: "Trainee Flutter Developer",
      company: "Young Decade Arch",
      duration: "2024 - Aug 2024",
      description:
          "Worked on Flutter UI implementation, API integrations, reusable component systems, and responsive application development.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 760;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 150,
        horizontal: isMobile ? 20 : 32,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.experience),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            from: 18,
            child: Text(
              'A progression through product engineering, frontend architecture, and scalable Flutter systems.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withOpacity(0.92),
                fontSize: isMobile ? 16 : 18,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 74),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1040),
            child: ScrollReveal(
              child: Column(
                children: List.generate(_entries.length, (index) {
                  return _AnimatedTimelineEntry(
                    entry: _entries[index],
                    isLast: index == _entries.length - 1,
                    isMobile: isMobile,
                    index: index,
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedTimelineEntry extends StatelessWidget {
  final _ExperienceEntry entry;
  final bool isLast;
  final bool isMobile;
  final int index;

  const _AnimatedTimelineEntry({
    required this.entry,
    required this.isLast,
    required this.isMobile,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final Widget row = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: Duration(milliseconds: 600 + (index * 120)),
                curve: Curves.easeOutBack,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.22),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (!isLast)
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: 1),
                    duration: Duration(milliseconds: 900 + (index * 120)),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          heightFactor: value,
                          child: Container(
                            width: 2,
                            color: Colors.white.withOpacity(0.14),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
          SizedBox(width: isMobile ? 18 : 30),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 38),
              child: _ExperienceCard(entry: entry, isMobile: isMobile),
            ),
          ),
        ],
      ),
    );

    return index.isEven
        ? FadeInLeft(
            duration: Duration(milliseconds: 720 + (index * 120)),
            from: 36,
            child: row,
          )
        : FadeInRight(
            duration: Duration(milliseconds: 720 + (index * 120)),
            from: 36,
            child: row,
          );
  }
}

class _ExperienceCard extends StatefulWidget {
  final _ExperienceEntry entry;
  final bool isMobile;

  const _ExperienceCard({required this.entry, required this.isMobile});

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.012 : 1,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        child: GlassContainer(
          padding: EdgeInsets.all(widget.isMobile ? 20 : 28),
          borderRadius: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    widget.entry.role,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: AppColors.divider),
                    ),
                    child: Text(
                      widget.entry.duration,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.72),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.entry.company,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                widget.entry.description,
                style: const TextStyle(color: AppColors.grey, height: 1.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceEntry {
  final String role;
  final String company;
  final String duration;
  final String description;

  const _ExperienceEntry({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
  });
}
