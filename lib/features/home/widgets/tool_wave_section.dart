import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';

class RedesignedTool {
  final String name;
  final String logoSlug; // simpleicons slug
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
  late final AnimationController _loopController;
  late final AnimationController _floatController;
  late final AnimationController _pulseController;

  int _activeScreenIndex = 0;
  Timer? _screenTimer;

  // Mouse tilt variables for the centerpiece phone
  Offset _mousePosition = Offset.zero;
  bool _isHovered = false;
  double _tiltX = 0.0;
  double _tiltY = 0.0;

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
      name: "VS Code",
      logoSlug: "visualstudiocode",
      fallbackIcon: Icons.code_rounded,
      brandColor: Color(0xFF007ACC),
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
    _loopController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _screenTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _activeScreenIndex = (_activeScreenIndex + 1) % 5;
        });
      }
    });
  }

  @override
  void dispose() {
    _loopController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    _screenTimer?.cancel();
    super.dispose();
  }

  void _onHover(PointerEvent event, Size size) {
    setState(() {
      _mousePosition = event.localPosition;
      _isHovered = true;

      final double normalizedX =
          (event.localPosition.dx - size.width / 2) / (size.width / 2);
      final double normalizedY =
          (event.localPosition.dy - size.height / 2) / (size.height / 2);

      _tiltX = -normalizedY * 8.0;
      _tiltY = normalizedX * 8.0;
    });
  }

  void _onHoverExit() {
    setState(() {
      _isHovered = false;
      _tiltX = 0.0;
      _tiltY = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollReveal(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 72),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1380),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BackdropTitle(title: "TOOLS"),
                const SizedBox(height: 26),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final bool compact = constraints.maxWidth < 860;
                    final bool tablet = constraints.maxWidth < 1180;

                    return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(compact ? 20 : 28),
                          decoration: BoxDecoration(
                            color: const Color(0xFF171717).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(
                              compact ? 28 : 40,
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.05),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x22000000),
                                blurRadius: 38,
                                offset: Offset(0, 18),
                              ),
                            ],
                          ),
                          child: compact
                              ? _buildCompactLayout(constraints.maxWidth)
                              : _buildWideLayout(
                                  constraints.maxWidth,
                                  tablet: tablet,
                                ),
                        )
                        .animate()
                        .fadeIn(duration: 700.ms)
                        .slideY(begin: 0.08, end: 0);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWideLayout(double width, {required bool tablet}) {
    final double phoneWidth = tablet ? 304 : 336;
    final double copyWidth = tablet ? 390 : 470;

    return SizedBox(
      height: tablet ? 670 : 720,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: copyWidth,
              child: _SectionCopy(
                headlineSize: tablet ? 58 : 68,
                paragraphSize: tablet ? 16 : 17,
                center: false,
              ),
            ),
          ),
          Positioned(
            left: -6,
            right: -10,
            bottom: 16,
            height: tablet ? 250 : 300,
            child: _WaveLogos(
              controller: _loopController,
              compact: false,
              tools: _tools,
            ),
          ),
          Positioned(
            right: 0,
            bottom: -4,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onHover: (e) => _onHover(e, Size(phoneWidth, phoneWidth * 1.95)),
              onExit: (_) => _onHoverExit(),
              child: AnimatedBuilder(
                animation: _floatController,
                builder: (context, child) {
                  final double floatVal =
                      math.sin(_floatController.value * math.pi * 2) * 8.0;
                  return Transform.translate(
                    offset: Offset(0, floatVal),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(_tiltX * math.pi / 180)
                        ..rotateY(_tiltY * math.pi / 180),
                      alignment: FractionalOffset.center,
                      child: child,
                    ),
                  );
                },
                child: _PhoneShowcase(
                  width: phoneWidth,
                  activeScreenIndex: _activeScreenIndex,
                  pulseController: _pulseController,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLayout(double width) {
    final bool smallPhone = width < 560;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionCopy(
          headlineSize: smallPhone ? 42 : 50,
          paragraphSize: 16,
          center: true,
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: smallPhone ? 170 : 195,
          child: _WaveLogos(
            controller: _loopController,
            compact: true,
            tools: _tools,
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onHover: (e) => _onHover(
              e,
              Size(smallPhone ? 266 : 292, (smallPhone ? 266 : 292) * 1.95),
            ),
            onExit: (_) => _onHoverExit(),
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                final double floatVal =
                    math.sin(_floatController.value * math.pi * 2) * 6.0;
                return Transform.translate(
                  offset: Offset(0, floatVal),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(_tiltX * math.pi / 180)
                      ..rotateY(_tiltY * math.pi / 180),
                    alignment: FractionalOffset.center,
                    child: child,
                  ),
                );
              },
              child: _PhoneShowcase(
                width: smallPhone ? 266 : 292,
                compact: true,
                activeScreenIndex: _activeScreenIndex,
                pulseController: _pulseController,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BackdropTitle extends StatelessWidget {
  final String title;

  const _BackdropTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double fontSize = width < 700 ? 64 : (width < 1100 ? 96 : 126);

    return SizedBox(
      width: double.infinity,
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.center,
          child: Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.white.withOpacity(0.05),
              fontSize: fontSize,
              letterSpacing: 0,
              height: 0.92,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCopy extends StatelessWidget {
  final double headlineSize;
  final double paragraphSize;
  final bool center;

  const _SectionCopy({
    required this.headlineSize,
    required this.paragraphSize,
    required this.center,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Wrap(
          alignment: center ? WrapAlignment.center : WrapAlignment.start,
          spacing: 10,
          runSpacing: 10,
          children: _platforms
              .map(
                (platform) =>
                    _PlatformChip(label: platform.label, icon: platform.icon),
              )
              .toList(),
        ),
        SizedBox(height: center ? 18 : 24),
        Text(
          "Tools &\nTechnologies",
          textAlign: center ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.cormorantGaramond(
            color: AppColors.orange,
            fontSize: headlineSize,
            height: 0.96,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(
            "The technologies, frameworks, platforms, and tools I use to build scalable, high-performance, production-ready applications.",
            textAlign: center ? TextAlign.center : TextAlign.left,
            style: TextStyle(
              color: Colors.white.withOpacity(0.84),
              fontSize: paragraphSize,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlatformChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _PlatformChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0x3DFFFFFF)),
        color: const Color(0x0DFFFFFF),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.orange),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveLogos extends StatelessWidget {
  final AnimationController controller;
  final bool compact;
  final List<RedesignedTool> tools;

  const _WaveLogos({
    required this.controller,
    required this.compact,
    required this.tools,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double waveHeight = constraints.maxHeight;
        final double waveWidth = constraints.maxWidth;
        final double badgeSize = compact ? 54 : 68;
        final double spacing = compact ? 84 : 98;
        final double arcLift = compact ? 22 : 54;
        final double baseY = compact ? waveHeight * 0.56 : waveHeight * 0.62;
        final double totalTrack = tools.length * spacing;

        return AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final double progress = controller.value;
            final double travel = progress * totalTrack;
            final List<Widget> badges = [];

            for (int i = 0; i < tools.length * 2; i++) {
              final RedesignedTool data = tools[i % tools.length];
              final double x =
                  ((i * spacing) + travel) % (totalTrack * 2) - badgeSize - 26;

              if (x < -badgeSize || x > waveWidth + badgeSize) {
                continue;
              }

              final double t = waveWidth == 0
                  ? 0
                  : (x / waveWidth).clamp(0.0, 1.0);
              final double arch = math.sin(t * math.pi) * arcLift;
              final double floatY =
                  math.sin((progress * math.pi * 2) + i * 0.42) *
                  (compact ? 4 : 6);
              final double y = baseY - arch + floatY;
              // slight rotation
              final double tilt =
                  math.sin((progress * math.pi * 2) + i * 0.16) * 0.08;

              badges.add(
                Positioned(
                  left: x,
                  top: y,
                  child: Transform.rotate(
                    angle: tilt,
                    child: _ToolBadgeCard(data: data, size: badgeSize),
                  ),
                ),
              );
            }

            return RepaintBoundary(
              child: ClipRect(
                child: Stack(clipBehavior: Clip.none, children: badges),
              ),
            );
          },
        );
      },
    );
  }
}

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
              borderRadius: BorderRadius.circular(widget.size * 0.26),
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
                size: widget.size * 0.46,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Brand SVG/Icon wrapper widget
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

class _PhoneShowcase extends StatelessWidget {
  final double width;
  final bool compact;
  final int activeScreenIndex;
  final AnimationController pulseController;

  const _PhoneShowcase({
    required this.width,
    required this.activeScreenIndex,
    required this.pulseController,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final double phoneHeight = width * 1.72;
    final bool tightCompact = compact && width <= 272;

    return SizedBox(
      width: width,
      height: phoneHeight + 20,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Ambient back glow
          AnimatedBuilder(
            animation: pulseController,
            builder: (context, child) {
              final glowScale = 1.0 + (pulseController.value * 0.08);
              return Positioned(
                left: -20,
                right: -20,
                top: -20,
                bottom: -20,
                child: Transform.scale(
                  scale: glowScale,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF5A36).withOpacity(0.12),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Main phone container
          Positioned(
            left: 0,
            bottom: 8,
            child: Container(
              width: width,
              height: phoneHeight,
              padding: EdgeInsets.all(tightCompact ? 6 : 8),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                borderRadius: BorderRadius.circular(36),
                border: Border.all(
                  color: const Color(0xFFFF5A36).withOpacity(0.88),
                  width: 2.4,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x55000000),
                    blurRadius: 30,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  color: const Color(0xFF0D0D0D),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(
                            begin: 0.95,
                            end: 1.0,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _buildScreen(activeScreenIndex, tightCompact),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreen(int index, bool dense) {
    switch (index) {
      case 0:
        return _buildChatScreen(dense);
      case 1:
        return _buildAIScreen(dense);
      case 2:
        return _buildDashboardScreen(dense);
      case 3:
        return _buildMeetingScreen(dense);
      case 4:
      default:
        return _buildEcomScreen(dense);
    }
  }

  Widget _buildChatScreen(bool dense) {
    return KeyedSubtree(
      key: const ValueKey(0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 10,
                  backgroundColor: Color(0xFFFF5A36),
                  child: Icon(Icons.person, size: 10, color: Colors.white),
                ),
                const SizedBox(width: 8),
                Text(
                  "Real-Time Chat",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: dense ? 10 : 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Spacer(),
            _simulatedBubble("Hey! Is the Flutter build ready?", false),
            const SizedBox(height: 6),
            _simulatedBubble("Yes! Built using Clean Architecture.", true),
            const SizedBox(height: 6),
            _simulatedBubble("Awesome, performance is super smooth!", false),
            const Spacer(),
            Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                "Type message...",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIScreen(bool dense) {
    return KeyedSubtree(
      key: const ValueKey(1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: Color(0xFFFF5A36),
                  size: 12,
                ),
                const SizedBox(width: 6),
                Text(
                  "Gemini AI Assistant",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: dense ? 10 : 11,
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
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withOpacity(0.06)),
              ),
              child: const Text(
                "How can I help you optimize your Flutter application architecture today?",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 9,
                  height: 1.4,
                ),
              ),
            ),
            const Spacer(),
            const Icon(Icons.mic, color: Color(0xFFFF5A36), size: 24)
                .animate(onPlay: (c) => c.repeat())
                .scale(
                  duration: 1000.ms,
                  begin: Offset(0.9, 0.9),
                  end: Offset(1.1, 1.1),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardScreen(bool dense) {
    return KeyedSubtree(
      key: const ValueKey(2),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: dense ? 11 : 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _statCard("Speed", "60 FPS", Colors.green)),
                const SizedBox(width: 6),
                Expanded(child: _statCard("Crash-Free", "99.9%", Colors.blue)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Icon(Icons.trending_up, color: Colors.green, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "APIs Response Time",
                          style: TextStyle(color: Colors.white70, fontSize: 8),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "120ms average",
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
      ),
    );
  }

  Widget _buildMeetingScreen(bool dense) {
    return KeyedSubtree(
      key: const ValueKey(3),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Standup Meeting",
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: dense ? 10 : 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "LIVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6,
                      fontWeight: FontWeight.w800,
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
                  _meetingTile("Ashutosh (You)", Colors.orange),
                  _meetingTile("Client Manager", Colors.blueGrey),
                  _meetingTile("Backend Lead", Colors.teal),
                  _meetingTile("QA Engineer", Colors.purple),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEcomScreen(bool dense) {
    return KeyedSubtree(
      key: const ValueKey(4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Store Showcase",
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: dense ? 11 : 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=120&auto=format&fit=crop&q=60",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Premium Sneakers",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "\$120.00",
                  style: TextStyle(
                    color: Color(0xFFFF5A36),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5A36),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Buy",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: const BoxConstraints(maxWidth: 100),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 8,
            height: 1.25,
          ),
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white54, fontSize: 7),
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
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Stack(
        children: [
          Center(child: Icon(Icons.videocam, color: color, size: 16)),
          Positioned(
            left: 4,
            bottom: 4,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
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

class _PlatformData {
  final String label;
  final IconData icon;

  const _PlatformData({required this.label, required this.icon});
}

const List<_PlatformData> _platforms = [
  _PlatformData(label: "iPhone", icon: Icons.phone_iphone_rounded),
  _PlatformData(label: "Mac", icon: Icons.laptop_mac_rounded),
  _PlatformData(label: "Windows", icon: Icons.window_rounded),
  _PlatformData(label: "Android", icon: Icons.android_rounded),
];
