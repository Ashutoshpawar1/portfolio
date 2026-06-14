import 'dart:math' as math;
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';
import '../../../utils/components/section_divider_transition.dart';

class RedesignedExperienceEntry {
  final String role;
  final String company;
  final String duration;
  final String location;
  final String employmentType;
  final String description;
  final List<String> techStack;
  final List<String> keyContributions;
  final Map<String, String> achievementMetrics;

  const RedesignedExperienceEntry({
    required this.role,
    required this.company,
    required this.duration,
    required this.location,
    required this.employmentType,
    required this.description,
    required this.techStack,
    required this.keyContributions,
    required this.achievementMetrics,
  });
}

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  final GlobalKey _sectionKey = GlobalKey();
  double _scrollFraction = 0.0;
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;
  bool _isSectionVisible = false;

  // Chronological order: Trainee (first) -> Developer (second)
  static const List<RedesignedExperienceEntry> _entries = [
    RedesignedExperienceEntry(
      role: "Trainee Flutter Developer",
      company: "Young Decade Arch",
      duration: "2024 - Aug 2024",
      location: "Indore, India",
      employmentType: "Trainee / Intern",
      description:
          "Worked on Flutter UI implementation, API integrations, reusable component systems, and responsive application development.",
      techStack: [
        "Flutter",
        "Dart",
        "BLoC",
        "REST APIs",
        "Firebase",
        "Responsive Layouts",
        "UI/UX Design",
      ],
      keyContributions: [
        "Designed and implemented pixel-perfect responsive user interfaces.",
        "Integrated REST APIs for backend database operations and CRUD features.",
        "Implemented Firebase Authentication, Firestore database, and Cloud Storage.",
        "Developed custom animations to improve user engagement and micro-interactions.",
        "Collaborated in design sprints to optimize overall application user experience.",
      ],
      achievementMetrics: {
        "Projects": "2+",
        "APIs": "15+",
        "Crash-Free": "98.5%",
        "Deployments": "1+",
      },
    ),
    RedesignedExperienceEntry(
      role: "Flutter Developer",
      company: "Developer Bazar Technologies",
      duration: "Nov 2024 - Present",
      location: "Indore, India",
      employmentType: "Full-Time",
      description:
          "Working on scalable Flutter applications involving real-time systems, API integrations, responsive UI engineering, and production deployment workflows.",
      techStack: [
        "Flutter",
        "Dart",
        "GetX",
        "REST APIs",
        "Socket.io",
        "Firebase",
        "Clean Architecture",
        "Git",
      ],
      keyContributions: [
        "Built scalable Flutter applications using Clean Architecture and GetX.",
        "Designed reusable architecture and cross-platform UI systems.",
        "Integrated complex REST APIs and Socket.IO for real-time applications.",
        "Implemented Firebase services, cloud messaging, and analytics.",
        "Developed real-time video conferencing and instant messaging systems.",
        "Optimized application performance, asset loading, and rendering speeds.",
      ],
      achievementMetrics: {
        "Projects": "5+",
        "APIs": "50+",
        "Crash-Free": "99.8%",
        "Deployments": "5+",
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().scrollController.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().scrollController.removeListener(_onScroll);
    }
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || !_isSectionVisible) return;
    final context = _sectionKey.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);
      final double viewportHeight = MediaQuery.of(context).size.height;
      final double sectionTop = position.dy;
      final double sectionHeight = box.size.height;

      final double startY = viewportHeight * 0.75;
      final double scrollPassed = startY - sectionTop;

      double fraction = 0.0;
      if (scrollPassed > 0) {
        fraction = (scrollPassed / (sectionHeight * 0.8)).clamp(0.0, 1.0);
      }

      if ((_scrollFraction - fraction).abs() > 0.01) {
        setState(() {
          _scrollFraction = fraction;
        });
      }
    }
  }

  void _handleHover(PointerEvent event) {
    setState(() {
      _mousePosition = event.localPosition;
      _isHovered = true;
    });
  }

  void _handleHoverExit() {
    setState(() {
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 760;

    return RepaintBoundary(
      child: VisibilityDetector(
        key: const Key('experience-section-visibility'),
        onVisibilityChanged: (info) {
          _isSectionVisible = info.visibleFraction > 0.0;
        },
        child: MouseRegion(
          onHover: _handleHover,
          onExit: (_) => _handleHoverExit(),
          child: Stack(
            key: _sectionKey,
          clipBehavior: Clip.none,
          children: [
            // Background grid overlay
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(painter: _ExperienceGridPainter()),
              ),
            ),

            // Parallax mouse follow glow
            if (_isHovered && !isMobile)
              Positioned(
                left: _mousePosition.dx - 300,
                top: _mousePosition.dy - 300,
                width: 600,
                height: 600,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF5A36).withOpacity(0.06),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            // Soft glowing blobs
            Positioned(
              top: 100,
              right: -120,
              width: 450,
              height: 450,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFFF5A36).withOpacity(0.015),
                    ),
                  ),
                ),
              ),
            ),

            // Main Content Layer
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: isMobile ? 80 : 120,
                bottom: 40,
                left: isMobile ? 16 : 40,
                right: isMobile ? 16 : 40,
              ),
              child: Column(
                children: [
                  // Single clean section title
                  const AnimatedSectionTitle(title: AppStrings.experience),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 820),
                    child: Text(
                      'A journey through software engineering, product development, scalable Flutter architecture, and production-ready solutions.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.68),
                        fontSize: isMobile ? 15 : 18,
                        height: 1.65,
                      ),
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05),
                  const SizedBox(height: 64),

                  // Horizontal layout of cards vertically stacked with a left timeline indicator
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Background continuous line
                        Positioned(
                          top: 40,
                          bottom: 80,
                          left: 20,
                          child: Container(
                            width: 2,
                            color: Colors.white.withOpacity(0.08),
                          ),
                        ),

                        // Active growing orange line
                        Positioned(
                          top: 40,
                          bottom: 80,
                          left: 20,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final activeHeight = constraints.maxHeight * _scrollFraction;
                              return Align(
                                alignment: Alignment.topCenter,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 2,
                                  height: activeHeight,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFF5A36),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFFF5A36),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Column of items
                        Column(
                          children: List.generate(_entries.length, (index) {
                            final entry = _entries[index];
                            final bool isFirst = index == 0;
                            final double activationThreshold = isFirst ? 0.25 : 0.65;
                            final bool isActivated = _scrollFraction >= activationThreshold;

                            return Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // The Dot
                                Positioned(
                                  left: 10,
                                  top: 30,
                                  child: _TimelineNodeDot(isActivated: isActivated),
                                ),
                                // The Card
                                Padding(
                                  padding: const EdgeInsets.only(left: 54, bottom: 40),
                                  child: _ExperienceHorizontalCard(
                                    entry: entry,
                                    isActivated: isActivated,
                                    index: index,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Section End text
                  FadeInUp(
                    duration: const Duration(milliseconds: 900),
                    from: 24,
                    child: Column(
                      children: [
                        Text(
                          "Building the future with Flutter, AI, and scalable software systems.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const SectionDividerTransition(
                          label: "Explore Tools",
                          nextSection: HomeSection.tools,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

// Glowing timeline node dot
class _TimelineNodeDot extends StatelessWidget {
  final bool isActivated;
  const _TimelineNodeDot({required this.isActivated});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActivated
            ? const Color(0xFFFF5A36)
            : Colors.white.withOpacity(0.12),
        border: Border.all(
          color: isActivated ? const Color(0xFFFF5A36) : Colors.white30,
          width: 2.5,
        ),
        boxShadow: isActivated
            ? [
                BoxShadow(
                  color: const Color(0xFFFF5A36).withOpacity(0.55),
                  blurRadius: 12,
                  spreadRadius: 3,
                ),
              ]
            : [],
      ),
      child: Center(
        child: AnimatedScale(
          scale: isActivated ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Redesigned wide horizontal card widget
class _ExperienceHorizontalCard extends StatefulWidget {
  final RedesignedExperienceEntry entry;
  final bool isActivated;
  final int index;

  const _ExperienceHorizontalCard({
    required this.entry,
    required this.isActivated,
    required this.index,
  });

  @override
  State<_ExperienceHorizontalCard> createState() =>
      _ExperienceHorizontalCardState();
}

class _ExperienceHorizontalCardState extends State<_ExperienceHorizontalCard> {
  bool _isHovered = false;
  double _rotateX = 0.0;
  double _rotateY = 0.0;

  void _onHover(PointerEvent event, Size size) {
    final double x = event.localPosition.dx;
    final double y = event.localPosition.dy;

    final double normalizedX = (x - size.width / 2) / (size.width / 2);
    final double normalizedY = (y - size.height / 2) / (size.height / 2);

    setState(() {
      _rotateX = -normalizedY * 2.5; // subtle tilt angle
      _rotateY = normalizedX * 2.5;
    });
  }

  void _onExit() {
    setState(() {
      _isHovered = false;
      _rotateX = 0.0;
      _rotateY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, 240);

        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onHover: (event) => _onHover(event, size),
          onExit: (_) => _onExit(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -4.0 : 0.0, 0.0),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // perspective
                ..rotateX(_rotateX * math.pi / 180)
                ..rotateY(_rotateY * math.pi / 180),
              alignment: FractionalOffset.center,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 600),
                opacity: widget.isActivated ? 1.0 : 0.0,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  scale: widget.isActivated ? 1.0 : 0.96,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: _isHovered
                              ? const Color(0xFFFF5A36).withOpacity(0.05)
                              : Colors.black.withOpacity(0.15),
                          blurRadius: _isHovered ? 28 : 16,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: GlassContainer(
                      borderRadius: 20,
                      blur: 16,
                      padding: EdgeInsets.all(isMobile ? 18 : 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: Job Title & Employment Type badge
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.entry.role,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile ? 18 : 22,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFFFF5A36,
                                  ).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(
                                      0xFFFF5A36,
                                    ).withOpacity(0.25),
                                  ),
                                ),
                                child: Text(
                                  widget.entry.employmentType.toUpperCase(),
                                  style: const TextStyle(
                                    color: Color(0xFFFF5A36),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Company, location, duration
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                widget.entry.company,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: isMobile ? 13 : 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              Text(
                                widget.entry.duration,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.55),
                                  fontSize: isMobile ? 12 : 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Short sweet description
                          Text(
                            widget.entry.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Key Contributions
                          const Text(
                            "KEY CONTRIBUTIONS",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...widget.entry.keyContributions.map((bullet) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 2.0),
                                    child: Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 14,
                                      color: Color(0xFFFF5A36),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      bullet,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.75),
                                        fontSize: 13,
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 20),

                          // Tech profile badges
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.entry.techStack.map((tech) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.06),
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.85),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          // Metrics block embedded directly inside card
                          const SizedBox(height: 20),
                          const Divider(color: Colors.white12),
                          const SizedBox(height: 12),
                          _buildAchievementMetrics(widget.entry),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAchievementMetrics(RedesignedExperienceEntry entry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: entry.achievementMetrics.entries.map((item) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.value,
                style: const TextStyle(
                  color: Color(0xFFFF5A36),
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item.key.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Background painter for the section grid overlay
class _ExperienceGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.007)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const double step = 60;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
