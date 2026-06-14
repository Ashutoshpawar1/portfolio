import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/services/external_link_service.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/section_divider_transition.dart';

// Rich local metadata for each project to power case studies
class RichProjectData {
  final ProjectModel project;
  final String category;
  final String duration;
  final String role;
  final String status;
  final List<String> metrics;
  final String problem;
  final String solution;
  final Map<String, String> architecture;
  final List<String> features;
  final List<String> learnings;
  final List<String> screenshots;
  final List<String> tags;
  final String businessImpact;
  final String contribution;
  final String timeline;

  RichProjectData({
    required this.project,
    required this.category,
    required this.duration,
    required this.role,
    required this.status,
    required this.metrics,
    required this.problem,
    required this.solution,
    required this.architecture,
    required this.features,
    required this.learnings,
    required this.screenshots,
    required this.tags,
    required this.businessImpact,
    required this.contribution,
    required this.timeline,
  });
}

// Maps base ProjectModel from app_strings to rich case study records
List<RichProjectData> _getRichProjects() {
  return appProjects.map((proj) {
    if (proj.title.toLowerCase().contains("wildlife")) {
      return RichProjectData(
        project: proj,
        category: "Enterprise Platform",
        duration: "8 Months",
        role: "Lead Flutter Developer",
        status: "Production Ready",
        metrics: [
          "50K+ Records Managed",
          "99.9% Core Uptime",
          "Offline Auto-Sync",
          "Multi-Role Flow",
        ],
        problem:
            "Managing wildlife shelter operations manually created critical inefficiencies in rescue dispatch tracking, real-time veterinary medical scheduling, automated reporting, and team coordination.",
        solution:
            "Designed and implemented a multi-role Flutter application integrated with Firebase, offering offline synchronization, geolocation dispatch tools, and dynamic PDF reports.",
        architecture: {
          "Frontend": "Flutter",
          "State Management": "GetX (Reactive States)",
          "Backend": "Firebase Services",
          "Local Database": "Hive & Firestore Cache",
          "Security Pattern": "Clean Architecture & SOLID",
        },
        features: [
          "Multi-Role Access Control (Admin, Vet, Rescuer)",
          "Real-Time Geolocation Dispatch Map",
          "Offline Data Caching & Auto-Sync",
          "Interactive Veterinary Medical Logging",
          "Push Notifications via Firebase Cloud Messaging",
          "Automated Shelter Performance Reporting",
        ],
        learnings: [
          "Designed highly resilient offline-first caching schemas in Hive/Firestore.",
          "Optimized heavy database query indexes to handle tens of thousands of records.",
          "Created custom PDF rendering libraries for responsive print generation.",
        ],
        screenshots: [
          "https://images.unsplash.com/photo-1501706362039-c6e80948f11f",
          "https://images.unsplash.com/photo-1504052434569-70ad5836ab65",
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
        ],
        tags: ["Flutter", "Firebase", "Enterprise", "Management"],
        businessImpact:
            "Digitized shelter rescue pipelines, decreasing rescue response times by 32% and reducing veterinary medical logging overhead by 40%.",
        contribution:
            "Architected offline-first synchronizers, designed the multi-role dashboard state machines using GetX, and engineered custom reports in Dart.",
        timeline: "Oct 2024 - May 2025",
      );
    } else if (proj.title.toLowerCase().contains("jayhyzmat")) {
      return RichProjectData(
        project: proj,
        category: "E-Commerce",
        duration: "6 Months",
        role: "Senior Flutter Developer",
        status: "Production Ready",
        metrics: [
          "10K+ Active Users",
          "99.8% Reliability",
          "Dynamic Bulk Filter",
        ],
        problem:
            "Industrial procurement workflows are traditionally slow, lacking centralized catalogs, multi-tier pricing filters, or digital order pipelines.",
        solution:
            "Developed a high-performance e-commerce procurement app featuring bulk ordering filters, offline-first catalogs, and account pricing matrices.",
        architecture: {
          "Frontend": "Flutter",
          "State Management": "GetX",
          "APIs": "REST API Integration",
          "Database Cache": "SQLite Local Cache",
          "Design Pattern": "Feature-First MVC Pattern",
        },
        features: [
          "Enterprise B2B Purchasing Portals",
          "Multi-tier Pricing & Currency Conversion",
          "Offline-First Product Catalog Search",
          "Automated PDF Invoices & Receipts",
          "Real-time Order Status Synchronization",
        ],
        learnings: [
          "Optimized image memory footprints to handle thousands of high-res industrial listings.",
          "Implemented background API polling queues to synchronize local caches.",
        ],
        screenshots: [
          "https://images.unsplash.com/photo-1494412651409-8963ce7935a7",
          "https://images.unsplash.com/photo-1511578314322-379afb476865",
        ],
        tags: ["Flutter", "Enterprise", "E-Commerce"],
        businessImpact:
            "Accelerated industrial procurement timelines by 50% and supported 10K+ monthly transactions securely.",
        contribution:
            "Developed B2B product listing filters, optimized SQLite catalog databases for fast searches, and built automated invoicing engines.",
        timeline: "Apr 2024 - Sep 2024",
      );
    } else if (proj.title.toLowerCase().contains("intercessory")) {
      return RichProjectData(
        project: proj,
        category: "Real-Time",
        duration: "5 Months",
        role: "Flutter & Integration Developer",
        status: "Production Ready",
        metrics: [
          "15K+ Active Members",
          "Real-Time Stream",
          "Instant Broadcast",
        ],
        problem:
            "Community members lacked a centralized, real-time workspace for meetings, live stream broadcasts, and event tracking.",
        solution:
            "Built a dedicated community social platform integrating Jitsi Meet SDK, cloud messaging broadcasts, and prayer walls.",
        architecture: {
          "Frontend": "Flutter",
          "State Management": "Riverpod (StateNotifier)",
          "Backend": "Firebase Services",
          "Database": "Firestore Real-time Sync",
          "Video SDK": "Jitsi Meet Native SDK",
        },
        features: [
          "In-App High-Quality Video Meetings",
          "Real-Time Threaded Group Chats",
          "Interactive Prayer Walls & Requests",
          "Instant Push Notification Alerts via FCM",
        ],
        learnings: [
          "Successfully resolved platform-specific lifecycle stutters when mounting Jitsi Web overlays.",
          "Engineered Firestore listeners to feed fluid real-time chat widgets.",
        ],
        screenshots: [
          "https://images.unsplash.com/photo-1504052434569-70ad5836ab65",
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
        ],
        tags: ["Flutter", "Firebase", "Real-Time"],
        businessImpact:
            "Increased faith-based community gathering frequencies, serving 15K+ members globally with low-latency broadcasts.",
        contribution:
            "Integrated and modified Jitsi Meet SDK layouts, managed real-time WebSockets listeners, and optimized FCM notifications.",
        timeline: "Nov 2023 - Mar 2024",
      );
    } else if (proj.title.toLowerCase().contains("lifevibe")) {
      return RichProjectData(
        project: proj,
        category: "AI Application",
        duration: "4 Months",
        role: "Flutter & AI Engineer",
        status: "Production Ready",
        metrics: [
          "5K+ Users Active",
          "Instant Meal Analysis",
          "Interactive Progress",
        ],
        problem:
            "Wellness trackers generally rely on tedious manual food entry which leads to swift user fatigue and dropping off.",
        solution:
            "Designed an AI assistant using Gemini to estimate macronutrients from food photographs and track daily wellness habits.",
        architecture: {
          "Frontend": "Flutter",
          "State Management": "BLoC Pattern",
          "AI Core": "Gemini Vision API integration",
          "Database": "Firestore Database",
          "Security": "Firebase Auth Integration",
        },
        features: [
          "AI Image-Based Meal Recognition Scanner",
          "Macronutrient Profile Estimates",
          "Dynamic Weight & Nutrition Graphs",
          "Personalized Daily AI Health Advice",
        ],
        learnings: [
          "Crafted precise system instructions to receive structured JSON objects from the LLM.",
          "Implemented canvas rendering tools to draw clean tracking statistics.",
        ],
        screenshots: [
          "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
          "https://images.unsplash.com/photo-1501706362039-c6e80948f11f",
        ],
        tags: ["Flutter", "Firebase", "AI"],
        businessImpact:
            "Achieved a 25% increase in user retention by removing friction from food entries through instant Gemini image analysis.",
        contribution:
            "Designed Gemini Vision prompting schemas, engineered habit tracking visualization charts, and built the nutrition BLoC pattern.",
        timeline: "Jul 2023 - Oct 2023",
      );
    } else {
      // MakeItHappn
      return RichProjectData(
        project: proj,
        category: "Management",
        duration: "3 Months",
        role: "Flutter Developer",
        status: "Production Ready",
        metrics: [
          "99.9% Server Uptime",
          "Automated Coordination",
          "REST API Sync",
        ],
        problem:
            "Scheduling meetups across large groups leads to endless email coordination and back-and-forth polling.",
        solution:
            "Built a smart calendar interface enabling group voting on available slots and auto-booking calendar entries.",
        architecture: {
          "Frontend": "Flutter",
          "State Management": "GetX",
          "APIs": "REST API Integration",
          "Calendar Core": "Google Calendar SDK",
        },
        features: [
          "Interactive Calendar Voting Grids",
          "Automated Synchronization with Google Calendar",
          "Frictionless Email RSVP Invites",
          "Group Preference Analytics Dashboards",
        ],
        learnings: [
          "Gained deep understanding of OAuth2 token refreshing and scopes.",
          "Created custom multi-user calendar synchronization blocks.",
        ],
        screenshots: [
          "https://images.unsplash.com/photo-1511578314322-379afb476865",
          "https://images.unsplash.com/photo-1494412651409-8963ce7935a7",
        ],
        tags: ["Flutter", "Real-Time"],
        businessImpact:
            "Automated meeting scheduling cycles, reducing average coordination loops from hours to less than 5 minutes.",
        contribution:
            "Implemented secure OAuth2 Google Calendar flows, created preference voting layout grid states, and configured sync polling.",
        timeline: "Apr 2023 - Jun 2023",
      );
    }
  }).toList();
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedTag = "All";
  late final List<RichProjectData> _allProjects = _getRichProjects();

  final List<String> _filterTags = [
    "All",
    "Flutter",
    "AI",
    "Firebase",
    "Enterprise",
    "Real-Time",
    "Management",
    "E-Commerce",
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 650;
    final bool isTablet = width >= 650 && width < 1050;

    // Filter project list based on selected tag
    final List<RichProjectData> filtered = _allProjects.where((p) {
      if (_selectedTag == "All") return true;
      return p.tags.contains(_selectedTag);
    }).toList();

    return _MouseFollowGlow(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Grid Overlay Background
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _GridBackgroundPainter()),
            ),
          ),
          // Floating animated background gradient orbs
          const _FloatingOrb(
            top: 80,
            right: -120,
            size: 340,
            color: Color(0xFFFF5A36),
          ),
          const _FloatingOrb(
            bottom: 180,
            left: -120,
            size: 380,
            color: Color(0xFF6366F1),
          ),
          // Soft Floating Particles
          const Positioned.fill(
            child: IgnorePointer(child: _BackgroundParticles()),
          ),
          // Main Section Layout
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: isMobile ? 80 : 120,
              bottom: 20,
              left: isMobile ? 18 : 40,
              right: isMobile ? 18 : 40,
            ),
             child: Column(
              children: [
                // Main section title
                const AnimatedSectionTitle(title: AppStrings.projectsTitle),
                const SizedBox(height: 24),

                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Text(
                    'Production-ready applications focused on scalability, performance, architecture, and user experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.68),
                      fontSize: isMobile ? 15 : 18,
                      height: 1.7,
                    ),
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05),
                const SizedBox(height: 36),

                // Projects Stats Row
                const _ProjectsStatsRow(),
                const SizedBox(height: 40),

                // Animated Filter Bar (Responsive)
                _buildFilterBar(isMobile),
                const SizedBox(height: 48),

                // Responsive Projects Grid Layout
                if (filtered.isNotEmpty) ...[
                  _buildProjectsGrid(filtered, isMobile, isTablet, width),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
                    child: Text(
                      "No projects match the selected category.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],

                // Section Transition Divider to Next Section (Skills)
                const SectionDividerTransition(
                  label: "Explore Skills",
                  nextSection: HomeSection.skills,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isMobile) {
    return _FilterBar(
      tags: _filterTags,
      selectedTag: _selectedTag,
      onTagSelected: (tag) => setState(() {
        _selectedTag = tag;
      }),
    );
  }

  Widget _buildProjectsGrid(
    List<RichProjectData> list,
    bool isMobile,
    bool isTablet,
    double screenWidth,
  ) {
    // Top/First item is highlighted as Featured
    final RichProjectData featured = list.first;
    final List<RichProjectData> others = list.skip(1).toList();

    final double spacing = 24.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Featured Project
          _FeaturedProjectCard(
                data: featured,
                onTap: () => _openCaseStudy(featured),
              )
              .animate()
              .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
              .scale(
                begin: const Offset(0.98, 0.98),
                duration: 600.ms,
                curve: Curves.easeOutCubic,
              ),
          if (others.isNotEmpty) ...[
            SizedBox(height: spacing),
            // 2. Horizontal scroll view of regular project cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: List.generate(others.length, (idx) {
                    final proj = others[idx];
                    return Padding(
                          padding: EdgeInsets.only(right: spacing),
                          child: SizedBox(
                            width: 360, // Consistent premium card width
                            child: _PremiumProjectCard(
                              data: proj,
                              onTap: () => _openCaseStudy(proj),
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(
                          delay: (idx * 150).ms,
                          duration: 600.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .slideX(
                          begin: 0.1,
                          end: 0.0,
                          duration: 600.ms,
                          curve: Curves.easeOutCubic,
                        )
                        .blurXY(
                          begin: 4,
                          end: 0,
                          duration: 600.ms,
                          curve: Curves.easeOutCubic,
                        );
                  }),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _openCaseStudy(RichProjectData project) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Case Study Modal",
      barrierColor: Colors.black.withOpacity(0.82),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, anim1, anim2) {
        return _ProjectDetailsModal(
          initialProject: project,
          allProjects: _allProjects,
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16 * anim1.value,
            sigmaY: 16 * anim1.value,
          ),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic),
            ),
            child: FadeTransition(opacity: anim1, child: child),
          ),
        );
      },
    );
  }
}

// Custom Chips Filter bar
class _FilterBar extends StatefulWidget {
  final List<String> tags;
  final String selectedTag;
  final Function(String) onTagSelected;

  const _FilterBar({
    required this.tags,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  State<_FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<_FilterBar> {
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: List.generate(widget.tags.length, (idx) {
        final tag = widget.tags[idx];
        final bool isSelected = tag == widget.selectedTag;
        final bool isHovered = idx == _hoveredIndex;

        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredIndex = idx),
          onExit: (_) => setState(() => _hoveredIndex = -1),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => widget.onTagSelected(tag),
            child: AnimatedScale(
              scale: isHovered && !isSelected ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFF5A36)
                      : Colors.white.withOpacity(0.015),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.05),
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: const Color(0xFFFF5A36).withOpacity(0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isHovered
                              ? Colors.white
                              : Colors.white.withOpacity(0.55)),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

// Mouse Follow Glow Effect behind the section
class _MouseFollowGlow extends StatefulWidget {
  final Widget child;
  const _MouseFollowGlow({required this.child});

  @override
  State<_MouseFollowGlow> createState() => _MouseFollowGlowState();
}

class _MouseFollowGlowState extends State<_MouseFollowGlow> {
  Offset _mousePos = Offset.zero;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          setState(() {
            _mousePos = box.globalToLocal(event.position);
          });
        }
      },
      child: Stack(
        children: [
          if (_isHovered)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _BackgroundGlowPainter(mousePos: _mousePos),
                ),
              ),
            ),
          widget.child,
        ],
      ),
    );
  }
}

class _BackgroundGlowPainter extends CustomPainter {
  final Offset mousePos;
  _BackgroundGlowPainter({required this.mousePos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFFF5A36).withOpacity(0.015),
              const Color(0xFF6366F1).withOpacity(0.01),
              Colors.transparent,
            ],
            radius: 0.5,
          ).createShader(
            Rect.fromCircle(center: mousePos, radius: size.width * 0.45),
          );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _BackgroundGlowPainter oldDelegate) =>
      oldDelegate.mousePos != mousePos;
}

// Grid Overlay Custom Painter
class _GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.009)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    const double step = 45;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridBackgroundPainter oldDelegate) => false;
}

// Background Orb
class _FloatingOrb extends StatefulWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double size;
  final Color color;

  const _FloatingOrb({
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.size,
    required this.color,
  });

  @override
  State<_FloatingOrb> createState() => _FloatingOrbState();
}

class _FloatingOrbState extends State<_FloatingOrb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(40, 25),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: _animation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.008),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.025),
                    blurRadius: widget.size / 2,
                    spreadRadius: widget.size / 4,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Soft Background Particles
class _BackgroundParticles extends StatefulWidget {
  const _BackgroundParticles();

  @override
  State<_BackgroundParticles> createState() => _BackgroundParticlesState();
}

class _BackgroundParticlesState extends State<_BackgroundParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(24, (index) => _Particle());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        for (var p in _particles) {
          p.update();
        }
        return CustomPaint(painter: _ParticlesPainter(particles: _particles));
      },
    );
  }
}

class _Particle {
  late double x;
  late double y;
  late double speedX;
  late double speedY;
  late double size;
  late double opacity;
  final math.Random _random = math.Random();

  _Particle() {
    x = _random.nextDouble();
    y = _random.nextDouble();
    speedX = (_random.nextDouble() - 0.5) * 0.0004;
    speedY = (_random.nextDouble() - 0.5) * 0.0004;
    size = _random.nextDouble() * 3.0 + 1.0;
    opacity = _random.nextDouble() * 0.08 + 0.02;
  }

  void update() {
    x += speedX;
    y += speedY;
    if (x < 0) x = 1.0;
    if (x > 1) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1) y = 0.0;
  }
}

class _ParticlesPainter extends CustomPainter {
  final List<_Particle> particles;
  _ParticlesPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    for (var p in particles) {
      paint.color = Colors.white.withOpacity(p.opacity);
      canvas.drawCircle(
        Offset(p.x * size.width, p.y * size.height),
        p.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlesPainter oldDelegate) => true;
}



// Stats Counter Row
class _ProjectsStatsRow extends StatelessWidget {
  const _ProjectsStatsRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: const [
        _ProjectStatItem(value: 5, suffix: "+", label: "Projects Delivered"),
        _ProjectStatItem(value: 2, suffix: "+", label: "Years Experience"),
        _ProjectStatItem(value: 10, suffix: "+", label: "Technologies"),
        _ProjectStatItem(value: 100, suffix: "%", label: "Production Focus"),
      ],
    );
  }
}

class _ProjectStatItem extends StatefulWidget {
  final int value;
  final String suffix;
  final String label;

  const _ProjectStatItem({
    required this.value,
    required this.suffix,
    required this.label,
  });

  @override
  State<_ProjectStatItem> createState() => _ProjectStatItemState();
}

class _ProjectStatItemState extends State<_ProjectStatItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimated = false;
  final Key _key = UniqueKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _trigger() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      if (mounted) _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05) _trigger();
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.012),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  "${_animation.value.round()}${widget.suffix}",
                  style: const TextStyle(
                    color: Color(0xFFFF5A36),
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// FEATURED PROJECT CARD
class _FeaturedProjectCard extends StatefulWidget {
  final RichProjectData data;
  final VoidCallback onTap;

  const _FeaturedProjectCard({required this.data, required this.onTap});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final bool isSmall = w < 960;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.006 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 320),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? const Color(0xFFFF5A36).withOpacity(0.06)
                        : Colors.black.withOpacity(0.35),
                    blurRadius: 48,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: GlassContainer(
                borderRadius: 28,
                blur: 16,
                padding: const EdgeInsets.all(0),
                child: isSmall ? _buildMobileLayout() : _buildDesktopLayout(),
              ),
            ),
            // Border Highlight Outline on Hover
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: _isHovered
                          ? const Color(0xFFFF5A36).withOpacity(0.24)
                          : Colors.white.withOpacity(0.03),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return SizedBox(
      height: 480,
      child: Row(
        children: [
          Expanded(flex: 5, child: _buildBannerImage(480)),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(child: _buildContent(false)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildBannerImage(260),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: _buildContent(true),
        ),
      ],
    );
  }

  Widget _buildBannerImage(double height) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        bottomLeft: Radius.circular(0),
        topRight: Radius.circular(28),
        bottomRight: Radius.circular(0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedScale(
              scale: _isHovered ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: CachedNetworkImage(
                imageUrl: widget.data.project.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(color: Colors.grey[900]),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.15),
                    Colors.black.withOpacity(0.55),
                  ],
                ),
              ),
            ),
          ),
          // Featured Tag overlay
          Positioned(
            top: 24,
            left: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A36),
                borderRadius: BorderRadius.circular(999),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF5A36).withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star_rounded, size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    "FEATURED PROJECT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A36).withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFFF5A36).withOpacity(0.2),
                ),
              ),
              child: Text(
                widget.data.category,
                style: const TextStyle(
                  color: Color(0xFFFF5A36),
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.data.project.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          widget.data.project.description,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),

        // Metrics row
        if (widget.data.metrics.isNotEmpty) ...[
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: widget.data.metrics.map((metric) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white.withOpacity(0.04)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.analytics_outlined,
                      size: 12,
                      color: Color(0xFFFF5A36),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      metric,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],

        // Architecture Highlights
        if (widget.data.architecture.isNotEmpty) ...[
          const Text(
            "ARCHITECTURE HIGHLIGHTS",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: widget.data.architecture.entries.take(3).map((entry) {
              return Text(
                "${entry.key}: ${entry.value}  •  ",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],

        // Tech Stack Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.data.project.tech.map((tech) {
            return _TechStackChip(label: tech);
          }).toList(),
        ),
        const SizedBox(height: 28),

        // Action Buttons Row
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: widget.onTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 240),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A36),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      if (_isHovered)
                        BoxShadow(
                          color: const Color(0xFFFF5A36).withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        "View Case Study",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.data.project.playStoreUrl.isNotEmpty)
              _FeaturedActionBtn(
                icon: Icons.android_rounded,
                label: "Google Play",
                url: widget.data.project.playStoreUrl,
              ),
            if (widget.data.project.appStoreUrl.isNotEmpty)
              _FeaturedActionBtn(
                icon: Icons.apple_rounded,
                label: "App Store",
                url: widget.data.project.appStoreUrl,
              ),
            if (widget.data.project.githubUrl != "#")
              _FeaturedActionBtn(
                icon: Icons.code_rounded,
                label: "GitHub",
                url: widget.data.project.githubUrl,
              ),
          ],
        ),
      ],
    );
  }
}

class _FeaturedActionBtn extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  const _FeaturedActionBtn({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_FeaturedActionBtn> createState() => _FeaturedActionBtnState();
}

class _FeaturedActionBtnState extends State<_FeaturedActionBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openExternalUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.06)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(_isHovered ? 0.25 : 0.08),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: 16, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TECH STACK CHIP W/ ANIMATION
class _TechStackChip extends StatefulWidget {
  final String label;
  const _TechStackChip({required this.label});

  @override
  State<_TechStackChip> createState() => _TechStackChipState();
}

class _TechStackChipState extends State<_TechStackChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFF5A36).withOpacity(0.08)
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFF5A36).withOpacity(0.3)
                  : Colors.white.withOpacity(0.04),
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFFFF5A36).withOpacity(0.12),
                  blurRadius: 8,
                ),
            ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isHovered
                  ? const Color(0xFFFF5A36)
                  : Colors.white.withOpacity(0.85),
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// PREMIUM REGULAR CARD
class _PremiumProjectCard extends StatefulWidget {
  final RichProjectData data;
  final VoidCallback onTap;

  const _PremiumProjectCard({required this.data, required this.onTap});

  @override
  State<_PremiumProjectCard> createState() => _PremiumProjectCardState();
}

class _PremiumProjectCardState extends State<_PremiumProjectCard> {
  Offset _mousePos = Offset.zero;
  bool _isHovered = false;
  double _tiltX = 0;
  double _tiltY = 0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _tiltX = 0;
        _tiltY = 0;
      }),
      onHover: (event) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final Offset local = box.globalToLocal(event.position);
        setState(() {
          _mousePos = local;
          final double w = box.size.width;
          final double h = box.size.height;
          // Calculate subtle tilt angle
          _tiltX = ((local.dy - h / 2) / (h / 2)) * 2.0;
          _tiltY = -((local.dx - w / 2) / (w / 2)) * 2.0;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_tiltX * math.pi / 180)
          ..rotateY(_tiltY * math.pi / 180),
        alignment: Alignment.center,
        child: Stack(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: _isHovered
                        ? const Color(0xFFFF5A36).withOpacity(0.05)
                        : Colors.black.withOpacity(0.25),
                    blurRadius: 36,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: GlassContainer(
                borderRadius: 24,
                blur: 16,
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBannerImage(),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.project.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.5,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.data.category,
                            style: const TextStyle(
                              color: Color(0xFFFF5A36),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            widget.data.project.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.65),
                              fontSize: 12.5,
                              height: 1.55,
                            ),
                          ),
                          const SizedBox(height: 18),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: widget.data.project.tech.take(3).map((
                              tech,
                            ) {
                              return _TechStackChip(label: tech);
                            }).toList(),
                          ),
                          const SizedBox(height: 22),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: widget.onTap,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 240),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 11,
                                ),
                                decoration: BoxDecoration(
                                  color: _isHovered
                                      ? const Color(0xFFFF5A36)
                                      : Colors.white.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _isHovered
                                        ? Colors.transparent
                                        : Colors.white.withOpacity(0.08),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "View Case Study",
                                    style: TextStyle(
                                      color: _isHovered
                                          ? Colors.white
                                          : Colors.white,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Border highlight outline
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isHovered
                          ? const Color(0xFFFF5A36).withOpacity(0.2)
                          : Colors.white.withOpacity(0.03),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            // Radial Glow Spotlight
            if (_isHovered)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _CardGlowPainter(mousePos: _mousePos),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SizedBox(
        height: 165,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedScale(
                scale: _isHovered ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                child: CachedNetworkImage(
                  imageUrl: widget.data.project.imageUrl,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) =>
                      Container(color: Colors.grey[900]),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.45),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dialog follow spotlight painter
class _CardGlowPainter extends CustomPainter {
  final Offset mousePos;
  _CardGlowPainter({required this.mousePos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFFF5A36).withOpacity(0.065),
              Colors.transparent,
            ],
            radius: 0.35,
          ).createShader(
            Rect.fromCircle(center: mousePos, radius: size.width * 0.32),
          );

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant _CardGlowPainter oldDelegate) =>
      oldDelegate.mousePos != mousePos;
}

// CASE STUDY PROJECT DETAILS MODAL
class _ProjectDetailsModal extends StatefulWidget {
  final RichProjectData initialProject;
  final List<RichProjectData> allProjects;

  const _ProjectDetailsModal({
    required this.initialProject,
    required this.allProjects,
  });

  @override
  State<_ProjectDetailsModal> createState() => _ProjectDetailsModalState();
}

class _ProjectDetailsModalState extends State<_ProjectDetailsModal> {
  late RichProjectData _project = widget.initialProject;
  int _activeScreenshotIndex = 0;
  Timer? _carouselTimer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startCarousel();
  }

  @override
  void dispose() {
    _carouselTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startCarousel() {
    _carouselTimer?.cancel();
    if (_project.screenshots.length > 1) {
      _carouselTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (mounted) {
          setState(() {
            _activeScreenshotIndex =
                (_activeScreenshotIndex + 1) % _project.screenshots.length;
          });
        }
      });
    }
  }

  void _switchProject(RichProjectData newProj) {
    setState(() {
      _project = newProj;
      _activeScreenshotIndex = 0;
    });
    _startCarousel();
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final bool isMobile = w < 760;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? double.infinity : w * 0.85,
          height: isMobile
              ? double.infinity
              : MediaQuery.of(context).size.height * 0.88,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.96),
            borderRadius: isMobile
                ? BorderRadius.zero
                : BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.8), blurRadius: 40),
            ],
          ),
          child: Column(
            children: [
              // Header Close Bar
              _buildCloseHeader(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 18 : 36,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Overview Panel & Screenshot Slideshow Grid
                      isMobile
                          ? Column(
                              children: [
                                _buildSlideshow(300),
                                const SizedBox(height: 24),
                                _buildOverviewPanel(),
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(flex: 3, child: _buildOverviewPanel()),
                                const SizedBox(width: 32),
                                Expanded(flex: 5, child: _buildSlideshow(350)),
                              ],
                            ),
                      const SizedBox(height: 36),

                      // Narrative Details (Problem / Solution)
                      _buildNarrativeGrid(isMobile),
                      const SizedBox(height: 36),

                      // Architecture Showcase
                      _buildArchitectureSection(isMobile),
                      const SizedBox(height: 36),

                      // Key Features List
                      _buildFeaturesGrid(isMobile),
                      const SizedBox(height: 36),

                      // Tech Stack Chips
                      _buildTechStackChips(),
                      const SizedBox(height: 36),

                      // Challenges, Learnings & Business Impact & Contribution
                      _buildNarrativeExtraGrid(isMobile),
                      const SizedBox(height: 48),

                      // Previous / Next Navigation
                      _buildPrevNextNavigation(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloseHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Row(
            children: const [
              Icon(Icons.terminal_rounded, color: Color(0xFFFF5A36), size: 16),
              SizedBox(width: 6),
              Text(
                "PRODUCTION CASE STUDY",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          const Spacer(),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.04),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewPanel() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _project.project.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _project.category,
            style: const TextStyle(
              color: Color(0xFFFF5A36),
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          _overviewMetaRow(
            Icons.calendar_month_outlined,
            "Timeline",
            _project.timeline,
          ),
          _overviewMetaRow(
            Icons.access_time_outlined,
            "Duration",
            _project.duration,
          ),
          _overviewMetaRow(Icons.person_outline_rounded, "Role", _project.role),
          _overviewMetaRow(Icons.verified_outlined, "Status", _project.status),
          const SizedBox(height: 20),

          // External CTA links
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (_project.project.playStoreUrl.isNotEmpty)
                _modalLinkBtn(
                  Icons.android_rounded,
                  "Play Store",
                  _project.project.playStoreUrl,
                ),
              if (_project.project.appStoreUrl.isNotEmpty)
                _modalLinkBtn(
                  Icons.apple_rounded,
                  "App Store",
                  _project.project.appStoreUrl,
                ),
              if (_project.project.githubUrl != "#")
                _modalLinkBtn(
                  Icons.code_rounded,
                  "GitHub",
                  _project.project.githubUrl,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewMetaRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 10),
          Text(
            "$label: ",
            style: const TextStyle(color: Colors.white54, fontSize: 12.5),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modalLinkBtn(IconData icon, String label, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openExternalUrl(url),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFF5A36).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFF5A36).withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: const Color(0xFFFF5A36)),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlideshow(double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: CachedNetworkImage(
                  key: ValueKey(_activeScreenshotIndex),
                  imageUrl: _project.screenshots[_activeScreenshotIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            // Dark gradient cover
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.35),
                    ],
                  ),
                ),
              ),
            ),
            // Slide controller indicators
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_project.screenshots.length, (idx) {
                  final bool isActive = _activeScreenshotIndex == idx;
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => setState(() => _activeScreenshotIndex = idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: isActive ? 28 : 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99),
                          color: isActive
                              ? const Color(0xFFFF5A36)
                              : Colors.white60,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNarrativeGrid(bool isMobile) {
    return Column(
      children: [
        _buildNarrativeCard(
          "PROBLEM STATEMENT",
          _project.problem,
          const Color(0xFFFF5A36),
          Icons.error_outline_rounded,
        ),
        const SizedBox(height: 18),
        _buildNarrativeCard(
          "SOLUTION PROVIDED",
          _project.solution,
          const Color(0xFF10B981),
          Icons.check_circle_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildNarrativeCard(
    String label,
    String text,
    Color accentColor,
    IconData icon,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: accentColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              height: 1.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ARCHITECTURE SHOWCASE",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            final int cols = isMobile ? 1 : 2;
            final double itemW = (w - (cols - 1) * 16) / cols;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _project.architecture.entries.map((entry) {
                return SizedBox(
                  width: itemW,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.015),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.04)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "KEY CAPABILITIES",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            final double w = constraints.maxWidth;
            final int cols = isMobile ? 1 : 2;
            final double itemW = (w - (cols - 1) * 16) / cols;

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: _project.features.map((feat) {
                return SizedBox(
                  width: itemW,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.01),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.03)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFFFF5A36),
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feat,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTechStackChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "INTEGRATED TECH STACK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _project.project.tech.map((tech) {
            return _TechStackChip(label: tech);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNarrativeExtraGrid(bool isMobile) {
    return Column(
      children: [
        _buildNarrativeCard(
          "BUSINESS IMPACT & RESULTS",
          _project.businessImpact,
          const Color(0xFF6366F1),
          Icons.trending_up_rounded,
        ),
        const SizedBox(height: 18),
        _buildNarrativeCard(
          "MY TECHNICAL CONTRIBUTION",
          _project.contribution,
          const Color(0xFFFF9F1C),
          Icons.engineering_outlined,
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.01),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.03)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.lightbulb_outline_rounded,
                    color: Color(0xFFFF9F1C),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "CHALLENGES & ARCHITECTURE LEARNINGS",
                    style: TextStyle(
                      color: Color(0xFFFF9F1C),
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...List.generate(_project.learnings.length, (idx) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: Colors.white54,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _project.learnings[idx],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 13.5,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPrevNextNavigation() {
    final int currIdx = widget.allProjects.indexOf(_project);
    final int prevIdx =
        (currIdx - 1 + widget.allProjects.length) % widget.allProjects.length;
    final int nextIdx = (currIdx + 1) % widget.allProjects.length;

    final RichProjectData prevProj = widget.allProjects[prevIdx];
    final RichProjectData nextProj = widget.allProjects[nextIdx];

    return Container(
      padding: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Project
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _switchProject(prevProj),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_rounded,
                        size: 14,
                        color: Colors.white54,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "PREVIOUS",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    prevProj.project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Next Project
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _switchProject(nextProj),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: const [
                      Text(
                        "NEXT",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Colors.white54,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    nextProj.project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


