import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';
import 'glass_container.dart';

class ProjectExtendedDetails {
  final String category;
  final String duration;
  final String teamSize;
  final String role;
  final String status;
  final String problemStatement;
  final String solution;
  final List<Map<String, String>> architecture;
  final List<String> keyFeatures;
  final List<String> techStack;
  final List<String> highlights;
  final List<String> challenges;
  final List<String> learnings;
  final List<String> screenshots;
  final String liveDemoUrl;
  final String caseStudyPdfUrl;

  ProjectExtendedDetails({
    required this.category,
    required this.duration,
    required this.teamSize,
    required this.role,
    required this.status,
    required this.problemStatement,
    required this.solution,
    required this.architecture,
    required this.keyFeatures,
    required this.techStack,
    required this.highlights,
    required this.challenges,
    required this.learnings,
    required this.screenshots,
    this.liveDemoUrl = '',
    this.caseStudyPdfUrl = '',
  });
}

final Map<String, ProjectExtendedDetails> _extendedDetailsMap = {
  "JayHyzmat": ProjectExtendedDetails(
    category: "B2B Procurement E-Commerce",
    duration: "12 Months",
    teamSize: "6 Developers",
    role: "Senior Flutter Web Developer",
    status: "Production Active",
    problemStatement: "Traditional industrial procurement suffered from long communication delays, lack of price transparency, and error-prone manual ordering systems. The business required a real-time, responsive multi-platform portal for industrial vendors.",
    solution: "Built a highly responsive Flutter web and mobile application utilizing REST APIs and caching structures. Created an optimized checkout and order workflow, integrated with enterprise ERP systems, and implemented robust multi-role vendor dashboard controls.",
    architecture: [
      {"layer": "Frontend", "value": "Flutter Web / Mobile"},
      {"layer": "State Management", "value": "Riverpod"},
      {"layer": "Backend", "value": "NestJS / Node.js"},
      {"layer": "Database", "value": "PostgreSQL"},
      {"layer": "Authentication", "value": "OAuth2 / JWT"},
      {"layer": "Storage", "value": "AWS S3"},
      {"layer": "Architecture", "value": "Clean Architecture"},
    ],
    keyFeatures: [
      "Multi-Role Access",
      "Real-Time Inventory",
      "Multi-currency Support",
      "Offline Order Drafts",
      "Dynamic PDF Invoicing",
      "Interactive Analytics Charts",
    ],
    techStack: ["Flutter", "Riverpod", "NestJS", "PostgreSQL", "AWS S3", "REST API", "Git"],
    highlights: [
      "\$2M+ Transactions",
      "10K+ Active Accounts",
      "Sub-100ms API Speed",
      "Web & Mobile Responsive",
    ],
    challenges: [
      "Optimizing initial Flutter web bundle loading time.",
      "Synchronizing high-frequency inventory changes in real-time.",
    ],
    learnings: [
      "Implementing Web render target enhancements via CanvasKit.",
      "Constructing advanced offline syncing mechanisms using Riverpod and local SQLite.",
    ],
    screenshots: [
      "https://images.unsplash.com/photo-1494412651409-8963ce7935a7",
      "https://images.unsplash.com/photo-1460925895917-afdab827c52f",
      "https://images.unsplash.com/photo-1551288049-bebda4e38f71",
    ],
    liveDemoUrl: "https://jayhyzmat.com",
    caseStudyPdfUrl: "https://jayhyzmat.com/case-study.pdf",
  ),
  "Intercessory Army": ProjectExtendedDetails(
    category: "Community & Video Collaboration Platform",
    duration: "6 Months",
    teamSize: "3 Developers",
    role: "Full Stack Flutter Developer",
    status: "App Store & Play Store Active",
    problemStatement: "Connecting thousands of global community members for daily live meetings, notifications, and prayer coordinate workflows without relying on costly commercial streaming packages.",
    solution: "Implemented a custom Jitsi Meet SDK integration within a Dart-based clean architecture layout. Set up Firebase Cloud Functions for dynamic push messaging and scheduler routines to handle high-concurrency event starts.",
    architecture: [
      {"layer": "Frontend", "value": "Flutter iOS & Android"},
      {"layer": "State Management", "value": "BLoC / Cubit"},
      {"layer": "Backend", "value": "Node.js / Express"},
      {"layer": "Database", "value": "Firestore"},
      {"layer": "Authentication", "value": "Firebase Auth & Apple Sign In"},
      {"layer": "Notifications", "value": "Firebase Cloud Messaging"},
      {"layer": "Storage", "value": "Firebase Storage"},
      {"layer": "Architecture", "value": "Feature-first Clean Architecture"},
    ],
    keyFeatures: [
      "Live Meeting Integration",
      "Interactive Prayer Walls",
      "Global Push Notifications",
      "Event Scheduling",
      "Multi-language Support",
      "In-app Donations",
    ],
    techStack: ["Flutter", "BLoC", "Jitsi Meet", "Firebase", "Node.js", "Express", "REST API"],
    highlights: [
      "25K+ Active Users",
      "1.5M+ Notifications/Mo",
      "99.99% Stream Uptime",
      "Low-latency Chat Rooms",
    ],
    challenges: [
      "Managing audio/video state during background/termination events.",
      "Optimizing real-time subscription queries to minimize Firestore reads.",
    ],
    learnings: [
      "Advanced WebRTC protocol handling in Flutter.",
      "Custom Android/iOS native platform channel configuration for SDK integrations.",
    ],
    screenshots: [
      "https://images.unsplash.com/photo-1504052434569-70ad5836ab65",
      "https://images.unsplash.com/photo-1516321318423-f06f85e504b3",
      "https://images.unsplash.com/photo-1543269865-cbf427effbad",
    ],
    liveDemoUrl: "https://intercessoryarmy.org",
  ),
  "LifeVibe": ProjectExtendedDetails(
    category: "AI-Powered Wellness & Nutrition Coach",
    duration: "5 Months",
    teamSize: "2 Developers",
    role: "Lead Developer & AI Integrator",
    status: "Deployed & Production Ready",
    problemStatement: "Most calorie and fitness tracking tools require cumbersome manual input, causing users to abandon progress. The goal was to build a fluid app that extracts meal stats directly from natural language and images.",
    solution: "Integrated Google Gemini Pro and custom Vision models into a sleek Flutter app. Built local database caching using Drift/Isar and designed beautiful custom charts for instant macro-nutrition visualization.",
    architecture: [
      {"layer": "Frontend", "value": "Flutter"},
      {"layer": "State Management", "value": "GetX"},
      {"layer": "Backend", "value": "Python FastAPI / Firebase Functions"},
      {"layer": "Database", "value": "Firestore & local SQLite (Drift)"},
      {"layer": "Authentication", "value": "Firebase Auth & Google Sign-In"},
      {"layer": "Storage", "value": "Firebase Storage"},
      {"layer": "AI Framework", "value": "Gemini Pro / TensorFlow"},
      {"layer": "Architecture", "value": "Clean Architecture / DDD"},
    ],
    keyFeatures: [
      "AI Food Image Recognition",
      "Natural Language Meal Logger",
      "Real-time Wellness Analytics",
      "Custom Progress Charts",
      "Smart Meal Recommendations",
      "Offline First Storage",
    ],
    techStack: ["Flutter", "GetX", "Gemini Pro", "FastAPI", "Firebase", "Drift", "Python"],
    highlights: [
      "AI Accuracy above 94%",
      "10K+ Daily Active Users",
      "Instant Offline Sync",
      "Smooth Interactive UI",
    ],
    challenges: [
      "Minimizing local AI inference latency.",
      "Handling large nutrition datasets offline efficiently.",
    ],
    learnings: [
      "Advanced prompt engineering structures for structured JSON outputs.",
      "Local database migration and caching strategies in Flutter.",
    ],
    screenshots: [
      "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
      "https://images.unsplash.com/photo-1526256262350-7da7584cf5eb",
      "https://images.unsplash.com/photo-1461749280684-dccba630e2f6",
    ],
    liveDemoUrl: "https://lifevibe.app",
  ),
  "MakeItHappn": ProjectExtendedDetails(
    category: "Collaborative Scheduling & Social Coordinator",
    duration: "4 Months",
    teamSize: "3 Developers",
    role: "Flutter & UI Lead",
    status: "Beta Testing Active",
    problemStatement: "Coordinating meeting times across calendars, time zones, and personal schedules manually takes endless back-and-forth emails. A tool was needed to let groups vote on times and auto-coordinate final slots.",
    solution: "Designed an interactive polling and calendar synchronization app in Flutter. Configured deep linking for instant invite sharing and integrated with Google/Outlook calendar APIs via clean REST wrappers.",
    architecture: [
      {"layer": "Frontend", "value": "Flutter Web / Mobile"},
      {"layer": "State Management", "value": "Riverpod"},
      {"layer": "Backend", "value": "Node.js / Go"},
      {"layer": "Database", "value": "MongoDB"},
      {"layer": "Authentication", "value": "Magic Links & Google Auth"},
      {"layer": "Storage", "value": "Firebase Storage"},
      {"layer": "Architecture", "value": "Repository Pattern"},
    ],
    keyFeatures: [
      "Google Calendar Sync",
      "Interactive Voting Boards",
      "Timezone Auto-Adjust",
      "Deep Linking Invitations",
      "Offline Mode",
      "Real-time Poll updates",
    ],
    techStack: ["Flutter", "Riverpod", "Node.js", "MongoDB", "REST API", "Deep Linking", "Git"],
    highlights: [
      "Sub-second sync time",
      "15K+ Polls Scheduled",
      "Responsive Web support",
      "Fluid Board Interactions",
    ],
    challenges: [
      "Handling complicated time-zone math.",
      "Syncing with multiple calendar provider APIs.",
    ],
    learnings: [
      "Complex OAuth2 integration flows.",
      "Advanced responsive design in Flutter web viewports.",
    ],
    screenshots: [
      "https://images.unsplash.com/photo-1511578314322-379afb476865",
      "https://images.unsplash.com/photo-1506784983877-45594efa4cbe",
      "https://images.unsplash.com/photo-1484480974693-2cae859b3a42",
    ],
  ),
  "Wildlife Shelter Management System": ProjectExtendedDetails(
    category: "Enterprise Management Platform",
    duration: "8 Months",
    teamSize: "4 Developers",
    role: "Flutter Developer",
    status: "Production Ready",
    problemStatement: "Managing wildlife shelters manually created inefficiencies in rescue operations, reporting, animal tracking, and resource management. The objective was to create a centralized platform capable of handling large-scale operational workflows.",
    solution: "Designed and implemented a multi-role Flutter application integrated with Firebase services, real-time updates, cloud storage, and scalable architecture patterns. Implemented role-based access control, analytics dashboards, reporting systems, and streamlined rescue workflows.",
    architecture: [
      {"layer": "Frontend", "value": "Flutter"},
      {"layer": "State Management", "value": "GetX"},
      {"layer": "Backend", "value": "Firebase"},
      {"layer": "Database", "value": "Firestore"},
      {"layer": "Authentication", "value": "Firebase Auth"},
      {"layer": "Notifications", "value": "FCM"},
      {"layer": "Storage", "value": "Firebase Storage"},
      {"layer": "Architecture", "value": "Clean Architecture"},
    ],
    keyFeatures: [
      "Multi-Role Access",
      "Real-Time Updates",
      "Analytics Dashboard",
      "Offline Support",
      "Push Notifications",
      "Cloud Sync",
      "Report Generation",
      "Responsive UI",
    ],
    techStack: ["Flutter", "GetX", "Firebase", "Firestore", "FCM", "REST API", "Git"],
    highlights: [
      "50K+ Records Managed",
      "99.9% Reliability",
      "Real-Time Chat",
      "Cross Platform Support",
      "Production Deployment",
      "Scalable Architecture",
    ],
    challenges: [
      "Managing large datasets efficiently.",
      "Optimizing application performance under real-time synchronization loads.",
      "Handling complex user roles and granular permissions.",
    ],
    learnings: [
      "Enterprise Clean Architecture design.",
      "Performance optimization in high-frequency Firestore data streams.",
      "Real-time telemetry and geolocation tracking systems.",
    ],
    screenshots: [
      "https://images.unsplash.com/photo-1501706362039-c6e80948f11f",
      "https://images.unsplash.com/photo-1551434678-e076c223a692",
      "https://images.unsplash.com/photo-1551288049-bebda4e38f71",
    ],
  ),
};

class ProjectDetailsDialog extends StatefulWidget {
  final ProjectModel project;
  final List<ProjectModel> allProjects;

  const ProjectDetailsDialog({
    super.key,
    required this.project,
    required this.allProjects,
  });

  static void show(BuildContext context, ProjectModel project, List<ProjectModel> allProjects) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss Details",
      barrierColor: Colors.black.withOpacity(0.75),
      transitionDuration: const Duration(milliseconds: 380),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutQuart,
            reverseCurve: Curves.easeInQuart,
          ),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return ProjectDetailsDialog(project: project, allProjects: allProjects);
      },
    );
  }

  @override
  State<ProjectDetailsDialog> createState() => _ProjectDetailsDialogState();
}

class _ProjectDetailsDialogState extends State<ProjectDetailsDialog> {
  late ProjectModel _currentProject;
  late ProjectExtendedDetails _details;
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  int _activeScreenshotIndex = 0;
  Timer? _slideshowTimer;

  @override
  void initState() {
    super.initState();
    _loadProject(widget.project);
  }

  void _loadProject(ProjectModel project) {
    setState(() {
      _currentProject = project;
      _details = _extendedDetailsMap[project.title] ??
          ProjectExtendedDetails(
            category: "Software Application",
            duration: "6 Months",
            teamSize: "3 Developers",
            role: "Flutter Developer",
            status: "Production Ready",
            problemStatement: "A modern software implementation addressing critical architectural challenges, user experience inefficiencies, and integration needs.",
            solution: "Designed and implemented a scalable cross-platform application utilizing clean coding principles, robust state management, and reliable data synchronization services.",
            architecture: [
              {"layer": "Frontend", "value": "Flutter"},
              {"layer": "State Management", "value": "GetX / Riverpod"},
              {"layer": "Backend", "value": "Firebase / Cloud Services"},
              {"layer": "Architecture", "value": "Clean Architecture"},
            ],
            keyFeatures: ["Multi-Role Access", "Real-Time Updates", "Cloud Sync", "Responsive UI"],
            techStack: project.tech,
            highlights: ["99.9% Reliability", "Production Deployed", "Scalable Architecture"],
            challenges: ["Handling real-time updates and synchronization.", "Optimizing rendering cycles on complex screens."],
            learnings: ["Advanced architectural design patterns.", "Performance optimization workflows."],
            screenshots: [
              project.imageUrl.isNotEmpty
                  ? project.imageUrl
                  : "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
            ],
          );
      _activeScreenshotIndex = 0;
    });

    _startSlideshow();
  }

  void _startSlideshow() {
    _slideshowTimer?.cancel();
    if (_details.screenshots.length > 1) {
      _slideshowTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
        if (_pageController.hasClients) {
          int nextPage = _activeScreenshotIndex + 1;
          if (nextPage >= _details.screenshots.length) {
            nextPage = 0;
          }
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOutCubic,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _slideshowTimer?.cancel();
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
      child: Center(
        child: Container(
          width: isMobile ? size.width : size.width * 0.85,
          height: isMobile ? size.height : size.height * 0.88,
          decoration: BoxDecoration(
            color: const Color(0xFF0C0C0C),
            borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.divider,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 50,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(24),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  // Scrollable Content
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.fromLTRB(
                        isMobile ? 18 : 34,
                        isMobile ? 70 : 80,
                        isMobile ? 18 : 34,
                        34,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Project Title & Subtitle
                          _buildHeaderSection(isMobile),
                          const SizedBox(height: 18),

                          // Metadata Grid
                          _buildMetadataGrid(isMobile),
                          const SizedBox(height: 28),

                          // Large Hero Banner / Slideshow
                          _buildHeroBanner(isMobile),
                          const SizedBox(height: 34),

                          // Body Content Layout
                          isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _buildBodyParts(isMobile),
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left Column: Storytelling (60%)
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: _buildLeftColumnParts(),
                                      ),
                                    ),
                                    const SizedBox(width: 38),
                                    // Right Column: Technical Stats & Features (40%)
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: _buildRightColumnParts(),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 44),

                          // Related Projects
                          _buildRelatedProjectsSection(),
                        ],
                      ),
                    ),
                  ),

                  // Floating Close Button (Top Right)
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _buildCloseButton(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return _HoverScaleButton(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.divider),
        ),
        child: const Icon(
          Icons.close_rounded,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildHeaderSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _currentProject.title,
          style: TextStyle(
            fontSize: isMobile ? 32 : 44,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          _details.category,
          style: TextStyle(
            fontSize: isMobile ? 15 : 17,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFFF5A36),
            letterSpacing: 0.5,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, curve: Curves.easeOutCubic);
  }

  Widget _buildMetadataGrid(bool isMobile) {
    final items = [
      {"label": "DURATION", "value": _details.duration},
      {"label": "TEAM SIZE", "value": _details.teamSize},
      {"label": "ROLE", "value": _details.role},
      {"label": "STATUS", "value": _details.status},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item["label"]!,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item["value"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildHeroBanner(bool isMobile) {
    final double bannerHeight = isMobile ? 220 : 380;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: bannerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.01),
          border: Border.all(color: AppColors.divider),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (idx) {
                setState(() {
                  _activeScreenshotIndex = idx;
                });
              },
              itemCount: _details.screenshots.length,
              itemBuilder: (context, index) {
                return Image.network(
                  _details.screenshots[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: bannerHeight,
                );
              },
            ),
            // Floating dot indicators
            if (_details.screenshots.length > 1)
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_details.screenshots.length, (index) {
                    final bool active = index == _activeScreenshotIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: active ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: active ? const Color(0xFFFF5A36) : Colors.white24,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    );
                  }),
                ),
              ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms).scale(begin: const Offset(0.98, 0.98), curve: Curves.easeOutBack);
  }

  List<Widget> _buildBodyParts(bool isMobile) {
    return [
      ..._buildLeftColumnParts(),
      const SizedBox(height: 34),
      ..._buildRightColumnParts(),
    ];
  }

  List<Widget> _buildLeftColumnParts() {
    return [
      // Description
      const Text(
        "Project Description",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 12),
      Text(
        _currentProject.description,
        style: const TextStyle(
          color: AppColors.grey,
          fontSize: 16,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 28),

      // Problem Statement
      _buildSectionBox(
        title: "PROBLEM STATEMENT",
        content: _details.problemStatement,
        accentColor: const Color(0xFFFF453A),
        icon: Icons.warning_amber_rounded,
      ),
      const SizedBox(height: 28),

      // Solution
      _buildSectionBox(
        title: "SOLUTION PROVIDED",
        content: _details.solution,
        accentColor: const Color(0xFF34C759),
        icon: Icons.check_circle_outline_rounded,
      ),
      const SizedBox(height: 28),

      // Challenges & Learnings
      const Text(
        "Challenges & Learnings",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 16),
      ..._details.challenges.map((c) => _buildBulletItem(c, Icons.trending_up_rounded, const Color(0xFFFF9500))),
      const SizedBox(height: 8),
      ..._details.learnings.map((l) => _buildBulletItem(l, Icons.lightbulb_outline_rounded, const Color(0xFF5AC8FA))),
    ];
  }

  List<Widget> _buildRightColumnParts() {
    return [
      // Architecture
      const Text(
        "Architecture Showcase",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      _buildArchitectureShowcase(),
      const SizedBox(height: 34),

      // Key Features
      const Text(
        "Key Features",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      _buildKeyFeatures(),
      const SizedBox(height: 34),

      // Tech Stack
      const Text(
        "Tech Stack",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      _buildTechStack(),
      const SizedBox(height: 34),

      // Development Highlights
      const Text(
        "Development Highlights",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      _buildHighlights(),
      const SizedBox(height: 34),

      // Live Links
      const Text(
        "Available Links",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 14),
      _buildLiveLinks(),
    ];
  }

  Widget _buildSectionBox({
    required String title,
    required String content,
    required Color accentColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.01),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
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
            content,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 15,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.grey,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArchitectureShowcase() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.8,
      ),
      itemCount: _details.architecture.length,
      itemBuilder: (context, index) {
        final item = _details.architecture[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.04)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item["layer"]!.toUpperCase(),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item["value"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyFeatures() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _details.keyFeatures.map((feature) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF141414),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF34C759),
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                feature,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTechStack() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _details.techStack.map((tech) {
        return _HoverTechChip(label: tech);
      }).toList(),
    );
  }

  Widget _buildHighlights() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.5,
      ),
      itemCount: _details.highlights.length,
      itemBuilder: (context, index) {
        final text = _details.highlights[index];
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.01),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFF5A36).withOpacity(0.12)),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFFF5A36),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLiveLinks() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        if (_details.liveDemoUrl.isNotEmpty)
          _buildLinkButton(
            icon: Icons.language_rounded,
            label: "Live Demo",
            url: _details.liveDemoUrl,
            primary: true,
          ),
        if (_currentProject.playStoreUrl.isNotEmpty)
          _buildLinkButton(
            icon: Icons.android_rounded,
            label: "Google Play",
            url: _currentProject.playStoreUrl,
          ),
        if (_currentProject.appStoreUrl.isNotEmpty)
          _buildLinkButton(
            icon: Icons.apple_rounded,
            label: "App Store",
            url: _currentProject.appStoreUrl,
          ),
        if (_currentProject.githubUrl.isNotEmpty && _currentProject.githubUrl != "#")
          _buildLinkButton(
            icon: Icons.code_rounded,
            label: "GitHub",
            url: _currentProject.githubUrl,
          ),
        if (_details.caseStudyPdfUrl.isNotEmpty)
          _buildLinkButton(
            icon: Icons.picture_as_pdf_rounded,
            label: "Case Study PDF",
            url: _details.caseStudyPdfUrl,
          ),
      ],
    );
  }

  Widget _buildLinkButton({
    required IconData icon,
    required String label,
    required String url,
    bool primary = false,
  }) {
    return _HoverScaleButton(
      onTap: () => openExternalUrl(url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: primary ? const Color(0xFFFF5A36) : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: primary ? Colors.transparent : Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            if (primary)
              BoxShadow(
                color: const Color(0xFFFF5A36).withOpacity(0.35),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedProjectsSection() {
    // Filter out active project
    final related = widget.allProjects
        .where((p) => p.title != _currentProject.title)
        .take(3)
        .toList();

    if (related.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Colors.white10),
        const SizedBox(height: 24),
        const Text(
          "You May Also Like",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: related.length,
            itemBuilder: (context, index) {
              final project = related[index];
              return _HoverScaleButton(
                onTap: () {
                  _loadProject(project);
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOutCubic,
                  );
                },
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.02),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.04)),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          project.imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              project.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _extendedDetailsMap[project.title]?.category ?? "Software Application",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.45),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white30,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HoverTechChip extends StatefulWidget {
  final String label;

  const _HoverTechChip({required this.label});

  @override
  State<_HoverTechChip> createState() => _HoverTechChipState();
}

class _HoverTechChipState extends State<_HoverTechChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFFFF5A36).withOpacity(0.08) : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: _isHovered ? const Color(0xFFFF5A36).withOpacity(0.3) : Colors.white.withOpacity(0.08),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: const Color(0xFFFF5A36).withOpacity(0.1),
                blurRadius: 8,
              ),
          ],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isHovered ? const Color(0xFFFF5A36) : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _HoverScaleButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverScaleButton({required this.child, required this.onTap});

  @override
  State<_HoverScaleButton> createState() => _HoverScaleButtonState();
}

class _HoverScaleButtonState extends State<_HoverScaleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: widget.child,
        ),
      ),
    );
  }
}
