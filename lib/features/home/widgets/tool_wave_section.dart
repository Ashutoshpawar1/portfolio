import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';
import '../../../controllers/home_controller.dart';

class RedesignedTool {
  final String name;
  final String logoSlug;
  final IconData fallbackIcon;
  final Color brandColor;

  const RedesignedTool({
    required this.name,
    required this.logoSlug,
    required this.fallbackIcon,
    required this.brandColor,
  });
}

class ToolWaveSection extends StatefulWidget {
  const ToolWaveSection({super.key});

  @override
  State<ToolWaveSection> createState() => _ToolWaveSectionState();
}

class _ToolWaveSectionState extends State<ToolWaveSection>
    with TickerProviderStateMixin {
  late final AnimationController _orbitController;
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  ScrollController? _scrollController;

  int _selectedPlatformIndex = 0; // 0: iPhone, 1: Mac, 2: Windows, 3: Android
  double _scrollOffset = 0.0;
  Offset _mousePosition = Offset.zero;
  bool _isMouseIn = false;

  static const List<RedesignedTool> _tools = [
    RedesignedTool(
      name: "Flutter",
      logoSlug: "flutter",
      fallbackIcon: Icons.flutter_dash,
      brandColor: Color(0xFF02569B),
    ),
    RedesignedTool(
      name: "Dart",
      logoSlug: "dart",
      fallbackIcon: Icons.code,
      brandColor: Color(0xFF0175C2),
    ),
    RedesignedTool(
      name: "Firebase",
      logoSlug: "firebase",
      fallbackIcon: Icons.local_fire_department,
      brandColor: Color(0xFFFFCA28),
    ),
    RedesignedTool(
      name: "GetX",
      logoSlug: "getx",
      fallbackIcon: Icons.route,
      brandColor: Color(0xFFD32F2F),
    ),
    RedesignedTool(
      name: "Riverpod",
      logoSlug: "riverpod",
      fallbackIcon: Icons.water_drop,
      brandColor: Color(0xFF00E676),
    ),
    RedesignedTool(
      name: "BLoC",
      logoSlug: "bloc",
      fallbackIcon: Icons.grid_view_rounded,
      brandColor: Color(0xFF42A5F5),
    ),
    RedesignedTool(
      name: "REST API",
      logoSlug: "postman",
      fallbackIcon: Icons.api,
      brandColor: Color(0xFFFF5722),
    ),
    RedesignedTool(
      name: "Socket.IO",
      logoSlug: "socketdotio",
      fallbackIcon: Icons.sync_alt,
      brandColor: Color(0xFF010101),
    ),
    RedesignedTool(
      name: "Python",
      logoSlug: "python",
      fallbackIcon: Icons.terminal,
      brandColor: Color(0xFF3776AB),
    ),
    RedesignedTool(
      name: "Gemini AI",
      logoSlug: "googlegemini",
      fallbackIcon: Icons.blur_on,
      brandColor: Color(0xFF8E75FF),
    ),
    RedesignedTool(
      name: "OpenAI",
      logoSlug: "openai",
      fallbackIcon: Icons.smart_toy,
      brandColor: Color(0xFF00A67E),
    ),
    RedesignedTool(
      name: "Git",
      logoSlug: "git",
      fallbackIcon: Icons.merge_type,
      brandColor: Color(0xFFF05032),
    ),
    RedesignedTool(
      name: "GitHub",
      logoSlug: "github",
      fallbackIcon: Icons.cloud_done,
      brandColor: Color(0xFFFFFFFF),
    ),
    RedesignedTool(
      name: "Android",
      logoSlug: "android",
      fallbackIcon: Icons.android,
      brandColor: Color(0xFF3DDC84),
    ),
    RedesignedTool(
      name: "iOS",
      logoSlug: "apple",
      fallbackIcon: Icons.phone_iphone,
      brandColor: Color(0xFFFFFFFF),
    ),
    RedesignedTool(
      name: "Windows",
      logoSlug: "windows",
      fallbackIcon: Icons.window,
      brandColor: Color(0xFF0078D6),
    ),
    RedesignedTool(
      name: "MacOS",
      logoSlug: "apple",
      fallbackIcon: Icons.laptop_mac,
      brandColor: Color(0xFFFFFFFF),
    ),
    RedesignedTool(
      name: "Linux",
      logoSlug: "linux",
      fallbackIcon: Icons.keyboard_command_key,
      brandColor: Color(0xFFFCC624),
    ),
    RedesignedTool(
      name: "Docker",
      logoSlug: "docker",
      fallbackIcon: Icons.storage,
      brandColor: Color(0xFF2496ED),
    ),
    RedesignedTool(
      name: "Postman",
      logoSlug: "postman",
      fallbackIcon: Icons.api,
      brandColor: Color(0xFFFF6C37),
    ),
    RedesignedTool(
      name: "JMeter",
      logoSlug: "apachejmeter",
      fallbackIcon: Icons.speed,
      brandColor: Color(0xFFD22128),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 25),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.isRegistered<HomeController>()) {
        _scrollController = Get.find<HomeController>().scrollController;
        _scrollController?.addListener(_onScroll);
      }
    });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (mounted && _scrollController != null) {
      setState(() {
        _scrollOffset = _scrollController!.offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _isMouseIn = true),
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          setState(() {
            _mousePosition = box.globalToLocal(e.position);
          });
        }
      },
      onExit: (_) => setState(() => _isMouseIn = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 1. Grid Background Overlay
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _SubtleGridPainter()),
            ),
          ),

          // 2. Glowing Blob Lights
          Positioned(
            left: -150,
            top: 100,
            width: 480,
            height: 480,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFF5A36).withOpacity(0.02),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -150,
            bottom: 200,
            width: 520,
            height: 520,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6366F1).withOpacity(0.015),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Mouse-Follow Glow Light
          if (_isMouseIn && !isMobile)
            Positioned(
              left: _mousePosition.dx - 250,
              top: _mousePosition.dy - 250,
              width: 500,
              height: 500,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFF5A36).withOpacity(0.045),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // 4. Parallax Background Watermark "TOOLS"
          Positioned(
            top: 40 + (_scrollOffset * 0.08),
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "TOOLS",
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.025),
                      fontSize: width < 600 ? 120 : (width < 1100 ? 180 : 250),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 5. Main Content Layout (Full-Width Experience, Box Removed)
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: isMobile ? 80 : 120,
              bottom: 60,
              left: isMobile ? 18 : (width < 1180 ? 36 : 56),
              right: isMobile ? 18 : (width < 1180 ? 36 : 56),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header Titles
                ScrollReveal(
                  child: Column(
                    children: [
                      Text(
                        "Tools & Technologies",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          color: AppColors.orange,
                          fontSize: isMobile ? 42 : 56,
                          height: 1.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 750),
                        child: Text(
                          "The technologies, frameworks, platforms, and tools I use to build scalable, production-ready applications.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: isMobile ? 15 : 17,
                            height: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Platform Selection Tabs (iPhone, Mac, Windows, Android)
                ScrollReveal(child: _buildPlatformTabs()),
                const SizedBox(height: 56),

                // Centerpiece: Ecosystem Showcase Area (Orbiting Icons + Device Shell)
                _buildShowcaseArea(width, isMobile),

                const SizedBox(height: 100),

                // Bottom: Dual Row Infinite Marquee
                ScrollReveal(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "DEVELOPMENT ECOSYSTEM STRIP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.35),
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _MarqueeRow(tools: _tools, reverse: false),
                      const SizedBox(height: 16),
                      _MarqueeRow(tools: _tools, reverse: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformTabs() {
    final List<({String label, IconData icon})> platforms = [
      (label: "iPhone", icon: Icons.phone_iphone_rounded),
      (label: "Mac", icon: Icons.laptop_mac_rounded),
      (label: "Windows", icon: Icons.window_rounded),
      (label: "Android", icon: Icons.android_rounded),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: List.generate(platforms.length, (index) {
        final platform = platforms[index];
        final bool isSelected = index == _selectedPlatformIndex;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedPlatformIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF5A36).withOpacity(0.12)
                    : Colors.white.withOpacity(0.015),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFF5A36).withOpacity(0.55)
                      : Colors.white.withOpacity(0.08),
                  width: 1.2,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFF5A36).withOpacity(0.12),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    platform.icon,
                    size: 16,
                    color: isSelected
                        ? const Color(0xFFFF5A36)
                        : Colors.white60,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    platform.label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildShowcaseArea(double screenWidth, bool isMobile) {
    // Determine showcase dimensions
    final double areaHeight = isMobile ? 480 : 640;
    final double deviceWidth = isMobile
        ? (_selectedPlatformIndex == 1 || _selectedPlatformIndex == 2
              ? 280
              : 180)
        : (_selectedPlatformIndex == 1 || _selectedPlatformIndex == 2
              ? 380
              : 220);

    // Radii of orbits
    final double rx1 = isMobile ? 120 : 200;
    final double ry1 = isMobile ? 55 : 85;

    final double rx2 = isMobile ? 180 : 290;
    final double ry2 = isMobile ? 80 : 125;

    final double rx3 = isMobile ? 240 : 380;
    final double ry3 = isMobile ? 110 : 165;

    final double tiltAngle = -12 * math.pi / 180; // Tilted orbits!

    return SizedBox(
      height: areaHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double centerX = constraints.maxWidth / 2;
          final double centerY = areaHeight / 2;

          return AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              final double progress = _orbitController.value;

              // Orbit paths list
              final List<Widget> backgroundOrbits = [
                Positioned.fill(
                  child: IgnorePointer(
                    child: CustomPaint(
                      painter: _OrbitPathPainter(
                        radiiX: [rx1, rx2, rx3],
                        radiiY: [ry1, ry2, ry3],
                        tiltAngle: tiltAngle,
                      ),
                    ),
                  ),
                ),
              ];

              // Floating Labels definitions (organic, static locations with micro floats)
              final List<Widget> floatingLabels = _buildFloatingLabels(
                centerX,
                centerY,
                isMobile,
              );

              // Orbit items partitioning for Z-depth
              final List<Widget> backLayer = [];
              final List<Widget> frontLayer = [];

              // Inner Orbit: Flutter, Firebase, Dart (Speed: 1.0)
              final List<RedesignedTool> innerTools = [
                _tools[0], // Flutter
                _tools[2], // Firebase
                _tools[1], // Dart
              ];
              _computeOrbitPositions(
                tools: innerTools,
                progress: progress,
                speedMultiplier: 1.0,
                rx: rx1,
                ry: ry1,
                tilt: tiltAngle,
                centerX: centerX,
                centerY: centerY,
                badgeSize: isMobile ? 42 : 52,
                backLayer: backLayer,
                frontLayer: frontLayer,
                phaseOffset: 0.0,
              );

              // Middle Orbit: REST API, Socket.IO, Python, Gemini (Speed: -0.6, reverse direction!)
              final List<RedesignedTool> middleTools = [
                _tools[6], // REST API (postman/api)
                _tools[7], // Socket.IO
                _tools[8], // Python
                _tools[9], // Gemini
              ];
              _computeOrbitPositions(
                tools: middleTools,
                progress: progress,
                speedMultiplier: -0.6,
                rx: rx2,
                ry: ry2,
                tilt: tiltAngle,
                centerX: centerX,
                centerY: centerY,
                badgeSize: isMobile ? 42 : 52,
                backLayer: backLayer,
                frontLayer: frontLayer,
                phaseOffset: math.pi / 4,
              );

              // Outer Orbit: Android, iOS, Windows, MacOS, Linux (Speed: 0.35)
              final List<RedesignedTool> outerTools = [
                _tools[13], // Android
                _tools[14], // iOS
                _tools[15], // Windows
                _tools[16], // MacOS
                _tools[17], // Linux
              ];
              _computeOrbitPositions(
                tools: outerTools,
                progress: progress,
                speedMultiplier: 0.35,
                rx: rx3,
                ry: ry3,
                tilt: tiltAngle,
                centerX: centerX,
                centerY: centerY,
                badgeSize: isMobile ? 42 : 52,
                backLayer: backLayer,
                frontLayer: frontLayer,
                phaseOffset: math.pi / 2,
              );

              // Central Showcase Device Shell
              final Widget deviceShell = Center(
                child: MouseRegion(
                  onEnter: (_) {},
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      // Slight breathing pulse and floating motion
                      final double floatY =
                          math.sin(_pulseController.value * math.pi * 2) * 5.0;
                      return Transform.translate(
                        offset: Offset(0, floatY),
                        child: child,
                      );
                    },
                    child: _buildDeviceFrame(deviceWidth),
                  ),
                ),
              );

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ...backgroundOrbits,
                  ...floatingLabels,
                  ...backLayer,
                  deviceShell,
                  ...frontLayer,
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _computeOrbitPositions({
    required List<RedesignedTool> tools,
    required double progress,
    required double speedMultiplier,
    required double rx,
    required double ry,
    required double tilt,
    required double centerX,
    required double centerY,
    required double badgeSize,
    required List<Widget> backLayer,
    required List<Widget> frontLayer,
    required double phaseOffset,
  }) {
    for (int i = 0; i < tools.length; i++) {
      final double angle =
          (progress * 2 * math.pi * speedMultiplier) +
          (i * 2 * math.pi / tools.length) +
          phaseOffset;

      // Coordinate calculations on tilted ellipse
      final double rawX = math.cos(angle) * rx;
      final double rawY = math.sin(angle) * ry;

      final double x =
          centerX +
          (rawX * math.cos(tilt) - rawY * math.sin(tilt)) -
          badgeSize / 2;
      final double y =
          centerY +
          (rawX * math.sin(tilt) + rawY * math.cos(tilt)) -
          badgeSize / 2;

      // Depth sorting based on raw Y position on path (top half is behind, bottom half is in front)
      final bool isBehind = rawY < 0;

      final Widget badge = Positioned(
        left: x,
        top: y,
        child: _ToolBadgeCard(data: tools[i], size: badgeSize),
      );

      if (isBehind) {
        backLayer.add(badge);
      } else {
        frontLayer.add(badge);
      }
    }
  }

  List<Widget> _buildFloatingLabels(
    double centerX,
    double centerY,
    bool isMobile,
  ) {
    final double scale = isMobile ? 0.6 : 1.0;
    final List<(String, Offset)> placements = [
      ("Riverpod", Offset(-240 * scale, -180 * scale)),
      ("GetX", Offset(200 * scale, -190 * scale)),
      ("BLoC", Offset(-260 * scale, 140 * scale)),
      ("Docker", Offset(240 * scale, 150 * scale)),
      ("OpenAI", Offset(-120 * scale, -230 * scale)),
      ("GitHub", Offset(100 * scale, -240 * scale)),
      ("Postman", Offset(-80 * scale, 220 * scale)),
      ("JMeter", Offset(80 * scale, 230 * scale)),
    ];

    return placements.map((p) {
      final double floatVal = _floatController.value * 2 * math.pi;
      final double phase = p.hashCode * 0.42;

      // Slow organic movement calculations
      final double dx = math.sin(floatVal + phase) * 12;
      final double dy = math.cos(floatVal * 0.8 + phase) * 12;
      final double rot = math.sin(floatVal * 0.4 + phase) * 0.08;
      final double opacity = 0.5 + 0.45 * math.sin(floatVal * 0.5 + phase);

      return Positioned(
        left: centerX + p.$2.dx + dx,
        top: centerY + p.$2.dy + dy,
        child: Transform.rotate(
          angle: rot,
          child: Opacity(
            opacity: opacity.clamp(0.2, 0.95),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.012),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                  width: 0.8,
                ),
              ),
              child: Text(
                p.$1,
                style: GoogleFonts.outfit(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDeviceFrame(double width) {
    // Dynamic Frame selection based on platform index
    final Widget screen = _buildScreen(_selectedPlatformIndex, width < 300);

    switch (_selectedPlatformIndex) {
      case 1: // MacBook Base
        return _MacBookFrame(width: width, child: screen);
      case 2: // Windows Monitor
        return _WindowsMonitorFrame(width: width, child: screen);
      case 3: // Android Phone
        return _AndroidFrame(width: width, child: screen);
      case 0: // iPhone
      default:
        return _IPhoneFrame(width: width, child: screen);
    }
  }

  Widget _buildScreen(int index, bool dense) {
    switch (index) {
      case 0:
        return _buildChatScreen(dense);
      case 1:
        return _buildDashboardScreen(dense);
      case 2:
        return _buildMeetingScreen(dense);
      case 3:
      default:
        return _buildAIScreen(dense);
    }
  }

  Widget _buildChatScreen(bool dense) {
    return Container(
      color: const Color(0xFF0F0F0F),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 8,
                backgroundColor: Color(0xFFFF5A36),
                child: Icon(Icons.person, size: 8, color: Colors.white),
              ),
              const SizedBox(width: 6),
              Text(
                "Dynamic Chat Flow",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: dense ? 9 : 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          _simulatedBubble("How is the web optimization going?", false),
          const SizedBox(height: 6),
          _simulatedBubble("60 FPS achieved using RepaintBoundaries!", true),
          const Spacer(),
          Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "Type a message...",
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIScreen(bool dense) {
    return Container(
      color: const Color(0xFF0C0C0C),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFFFF5A36),
                size: 11,
              ),
              const SizedBox(width: 5),
              Text(
                "Gemini Integration",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: dense ? 9 : 10,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.06)),
            ),
            child: const Text(
              "Executing system instructions. Structured response payload completed in 120ms.",
              style: TextStyle(color: Colors.white70, fontSize: 8, height: 1.4),
            ),
          ),
          const Spacer(),
          const Icon(Icons.mic, color: Color(0xFFFF5A36), size: 20)
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 1000.ms,
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
              ),
        ],
      ),
    );
  }

  Widget _buildDashboardScreen(bool dense) {
    return Container(
      color: const Color(0xFF101010),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Core Performance Analytics",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: dense ? 10 : 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.query_stats_rounded,
                color: Colors.white.withOpacity(0.4),
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _statCard("FPS", "120 FPS", Colors.green)),
              const SizedBox(width: 8),
              Expanded(child: _statCard("Uptime", "99.98%", Colors.blue)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.02),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.04)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.flash_on_rounded,
                  color: Color(0xFFFF5A36),
                  size: 16,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "REST Endpoints latency",
                        style: TextStyle(color: Colors.white54, fontSize: 8),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "85ms avg latency",
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingScreen(bool dense) {
    return Container(
      color: const Color(0xFF0A0A0A),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jitsi Video Broadcast",
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: dense ? 9 : 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "REC",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 6,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _meetingTile("Ashutosh (Dev)", const Color(0xFFFF5A36)),
                _meetingTile("Tech Lead", Colors.indigo),
                _meetingTile("Project Owner", Colors.teal),
                _meetingTile("UI Designer", Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _simulatedBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFFFF5A36).withOpacity(0.85)
              : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
        ),
        constraints: const BoxConstraints(maxWidth: 120),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 7.5,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.015),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white38, fontSize: 7),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _meetingTile(String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.videocam, color: color, size: 14)),
          Positioned(
            left: 4,
            bottom: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Device Mockup Wrapper Widgets
class _IPhoneFrame extends StatelessWidget {
  final Widget child;
  final double width;

  const _IPhoneFrame({required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    final double height = width * 2.12;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(38),
        border: Border.all(
          color: const Color(0xFFFF5A36).withOpacity(0.7),
          width: 2.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.65),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Positioned.fill(child: child),
            // Dynamic Island
            Positioned(
              top: 8,
              left: (width - 16) / 2 - 32,
              child: Container(
                width: 64,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AndroidFrame extends StatelessWidget {
  final Widget child;
  final double width;

  const _AndroidFrame({required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    final double height = width * 2.16;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF3DDC84).withOpacity(0.7),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.65),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(child: child),
            // Punch hole camera
            Positioned(
              top: 8,
              left: (width - 12) / 2 - 4,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MacBookFrame extends StatelessWidget {
  final Widget child;
  final double width;

  const _MacBookFrame({required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    final double height = width * 0.625;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0D0D0D),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(color: const Color(0xFF080808), child: child),
          ),
        ),
        Container(
          width: width * 1.12,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
        ),
        Container(
          width: width * 0.2,
          height: 3,
          decoration: const BoxDecoration(
            color: Color(0xFF151515),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}

class _WindowsMonitorFrame extends StatelessWidget {
  final Widget child;
  final double width;

  const _WindowsMonitorFrame({required this.child, required this.width});

  @override
  Widget build(BuildContext context) {
    final double height = width * 0.5625;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(color: const Color(0xFF080808), child: child),
          ),
        ),
        Container(
          width: 24,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E2E),
            border: Border.symmetric(
              vertical: BorderSide(color: Colors.white.withOpacity(0.08)),
            ),
          ),
        ),
        Container(
          width: 100,
          height: 6,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Subtle Background Grid Overlay Painter
class _SubtleGridPainter extends CustomPainter {
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
  bool shouldRepaint(covariant _SubtleGridPainter oldDelegate) => false;
}

// Orbit Path Visualizer Rings Painter
class _OrbitPathPainter extends CustomPainter {
  final List<double> radiiX;
  final List<double> radiiY;
  final double tiltAngle;

  _OrbitPathPainter({
    required this.radiiX,
    required this.radiiY,
    required this.tiltAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(tiltAngle);

    for (int i = 0; i < radiiX.length; i++) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset.zero,
          width: radiiX[i] * 2,
          height: radiiY[i] * 2,
        ),
        paint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _OrbitPathPainter oldDelegate) => false;
}

// Tool Badge Card circular widgets
class _ToolBadgeCard extends StatefulWidget {
  final RedesignedTool data;
  final double size;

  const _ToolBadgeCard({required this.data, required this.size});

  @override
  State<_ToolBadgeCard> createState() => _ToolBadgeCardState();
}

class _ToolBadgeCardState extends State<_ToolBadgeCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Tooltip(
          message: widget.data.name,
          decoration: BoxDecoration(
            color: const Color(0xFF171717).withOpacity(0.92),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFFF5A36).withOpacity(0.3)),
          ),
          textStyle: const TextStyle(color: Colors.white, fontSize: 11),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered
                    ? const Color(0xFFFF5A36)
                    : Colors.white.withOpacity(0.08),
                width: 1.5,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFF5A36).withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [
                      const BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 22,
                        offset: Offset(0, 12),
                      ),
                    ],
            ),
            child: Center(
              child: _BrandIconWidget(
                slug: widget.data.logoSlug,
                fallbackIcon: widget.data.fallbackIcon,
                brandColor: widget.data.brandColor,
                size: widget.size * 0.44,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandIconWidget extends StatelessWidget {
  final String slug;
  final IconData fallbackIcon;
  final Color brandColor;
  final double size;

  const _BrandIconWidget({
    required this.slug,
    required this.fallbackIcon,
    required this.brandColor,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (slug == "getx" || slug == "riverpod" || slug == "bloc") {
      final String letter = slug == "getx"
          ? "G"
          : (slug == "riverpod" ? "R" : "B");
      return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: brandColor.withOpacity(0.15),
          border: Border.all(color: brandColor.withOpacity(0.4), width: 1.0),
        ),
        child: Text(
          letter,
          style: GoogleFonts.outfit(
            color: brandColor,
            fontSize: size * 0.65,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }

    return SvgPicture.network(
      "https://cdn.simpleicons.org/$slug",
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(brandColor, BlendMode.srcIn),
      placeholderBuilder: (context) =>
          Icon(fallbackIcon, color: brandColor, size: size),
    );
  }
}

// Infinite Horizontal scrolling marquee widgets with Hover pause
class _MarqueeRow extends StatefulWidget {
  final List<RedesignedTool> tools;
  final bool reverse;

  const _MarqueeRow({required this.tools, required this.reverse});

  @override
  State<_MarqueeRow> createState() => _MarqueeRowState();
}

class _MarqueeRowState extends State<_MarqueeRow>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _animController.addListener(_updateScrollOffset);
      }
    });
  }

  void _updateScrollOffset() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final halfScroll = maxScroll / 2;

    double val = _animController.value;
    if (widget.reverse) {
      val = 1.0 - val;
    }

    final double targetOffset = val * halfScroll;
    _scrollController.jumpTo(targetOffset);
  }

  @override
  void dispose() {
    _animController.removeListener(_updateScrollOffset);
    _animController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Duplicate tools array to allow infinite seamless jumping loop
    final List<RedesignedTool> duplicated = [...widget.tools, ...widget.tools];

    return MouseRegion(
      onEnter: (_) => _animController.stop(canceled: false),
      onExit: (_) => _animController.repeat(),
      child: SizedBox(
        height: 72,
        child: RepaintBoundary(
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: duplicated.length,
            itemBuilder: (context, index) {
              final tool = duplicated[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: _ToolCompactChip(data: tool),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Compact tag chip for Marquees
class _ToolCompactChip extends StatelessWidget {
  final RedesignedTool data;
  const _ToolCompactChip({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.015),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BrandIconWidget(
            slug: data.logoSlug,
            fallbackIcon: data.fallbackIcon,
            brandColor: data.brandColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            data.name,
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
