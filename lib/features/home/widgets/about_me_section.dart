import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../constants/app_colors.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/section_divider_transition.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 820;
    final bool isTablet = width >= 820 && width < 1180;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Grid Overlay Background
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _GridBackgroundPainter()),
          ),
        ),
        // Floating blurred gradient orbs
        const _FloatingOrb(
          top: 40,
          left: -100,
          size: 320,
          color: Color(0xFFFF5A36),
        ),
        const _FloatingOrb(
          top: 350,
          right: -120,
          size: 380,
          color: Color(0xFF6366F1),
        ),
        const _FloatingOrb(
          bottom: -80,
          left: 100,
          size: 280,
          color: Color(0xFF10B981),
        ),
        // Custom Particle system
        const Positioned.fill(child: IgnorePointer(child: _AboutParticles())),
        // Main Content Wrapper
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 80 : 120,
            horizontal: isMobile ? 18 : (isTablet ? 36 : 56),
          ),
          child: Column(
            children: [
              // Custom animated watermark background title
              const _AboutWatermark(),
              const SizedBox(height: 12),
              const AnimatedSectionTitle(title: AppStrings.aboutTitle),
              SizedBox(height: isMobile ? 32 : 48),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1100),
                child: _InteractiveCardWrapper(
                  child: GlassContainer(
                    padding: EdgeInsets.all(isMobile ? 22 : 36),
                    borderRadius: 34,
                    blur: 16,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Floating Flutter Logo Watermark inside Card
                        Positioned(
                          right: -32,
                          bottom: -32,
                          child: Opacity(
                            opacity: 0.02,
                            child: Transform.rotate(
                              angle: -0.18,
                              child: const FlutterLogo(size: 180),
                            ),
                          ),
                        ),
                        // Card Content
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card header with tag and accent line
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.03),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(
                                      color: AppColors.divider,
                                    ),
                                  ),
                                  child: Text(
                                    "ABOUT",
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                // Section Progress Indicator
                                const _SectionProgressIndicator(),
                              ],
                            ),
                            SizedBox(height: isMobile ? 32 : 40),
                            // Timeline and bio text row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (!isMobile) ...[
                                  // Vertical timeline accent line
                                  const _TimelineAccentLine(),
                                  const SizedBox(width: 32),
                                ],
                                Expanded(child: const _AboutParagraphs()),
                              ],
                            ),
                            SizedBox(height: isMobile ? 40 : 54),
                            // Animated stats counters
                            const _AboutStatsGrid(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const SectionDividerTransition(
                label: "Explore Projects",
                nextSection: HomeSection.projects,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

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

class _AboutParticles extends StatefulWidget {
  const _AboutParticles();

  @override
  State<_AboutParticles> createState() => _AboutParticlesState();
}

class _AboutParticlesState extends State<_AboutParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(18, (index) => _Particle());
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
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          for (var p in _particles) {
            p.update();
          }
          return CustomPaint(painter: _ParticlesPainter(particles: _particles));
        },
      ),
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
    speedX = (_random.nextDouble() - 0.5) * 0.0006;
    speedY = (_random.nextDouble() - 0.5) * 0.0006;
    size = _random.nextDouble() * 2.5 + 1.2;
    opacity = _random.nextDouble() * 0.12 + 0.03;
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

class _AboutWatermark extends StatelessWidget {
  const _AboutWatermark();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
          final double offset = controller.scrollOffset;
          // Parallax calculation
          final double translateY = (offset - 500) * 0.12;

          return Transform.translate(
            offset: Offset(0, translateY),
            child: Text(
              "ABOUT ME",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 600 ? 54 : 110,
                fontWeight: FontWeight.w800,
                color: Colors.white.withOpacity(0.04),
                letterSpacing: 2,
                height: 0.9,
              ),
            ),
          );
        })
        .animate()
        .fadeIn(duration: 1200.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: Curves.easeOutCubic,
        );
  }
}

class _InteractiveCardWrapper extends StatefulWidget {
  final Widget child;
  const _InteractiveCardWrapper({required this.child});

  @override
  State<_InteractiveCardWrapper> createState() =>
      _InteractiveCardWrapperState();
}

class _InteractiveCardWrapperState extends State<_InteractiveCardWrapper> {
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
          // Scale tilt maximum to 1.2 degrees for subtle web effect
          _tiltX = ((local.dy - h / 2) / (h / 2)) * 1.2;
          _tiltY = -((local.dx - w / 2) / (w / 2)) * 1.2;
        });
      },
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_tiltX * math.pi / 180)
          ..rotateY(_tiltY * math.pi / 180),
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? const Color(0xFFFF5A36).withOpacity(0.06)
                    : Colors.black.withOpacity(0.3),
                blurRadius: 36,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Stack(
            children: [
              widget.child,
              // Border glow on hover
              Positioned.fill(
                child: IgnorePointer(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      border: Border.all(
                        color: _isHovered
                            ? const Color(0xFFFF5A36).withOpacity(0.18)
                            : Colors.white.withOpacity(0.03),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              // Mouse cursor radial glow
              if (_isHovered)
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(34),
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
      ),
    );
  }
}

class _CardGlowPainter extends CustomPainter {
  final Offset mousePos;
  _CardGlowPainter({required this.mousePos});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              const Color(0xFFFF5A36).withOpacity(0.06),
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

class _SectionProgressIndicator extends StatelessWidget {
  const _SectionProgressIndicator();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final double offset = controller.scrollOffset;
      // Map scrollOffset (e.g. from 500 to 1200) to a fraction (0.0 to 1.0)
      final double progress = ((offset - 400) / 700).clamp(0.0, 1.0);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SECTION PROGRESS",
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: 110,
            height: 3,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: 110 * progress,
                height: 3,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5A36),
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF5A36).withOpacity(0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _TimelineAccentLine extends StatelessWidget {
  const _TimelineAccentLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.2,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFF5A36),
            const Color(0xFFFF5A36).withOpacity(0.35),
            Colors.white.withOpacity(0.02),
          ],
          stops: const [0.0, 0.45, 1.0],
        ),
      ),
    );
  }
}

class _AboutParagraphs extends StatelessWidget {
  const _AboutParagraphs();

  @override
  Widget build(BuildContext context) {
    final List<String> paragraphs = [
      "I am a Flutter Developer with 2+ years of experience building scalable mobile and web applications focused on performance, maintainability, and user experience.",
      "My expertise includes Flutter, Firebase, REST APIs, state management solutions such as BLoC, Riverpod, and GetX, along with real-time communication systems and scalable application architecture.",
      "Throughout my journey, I have developed production-ready applications across multiple domains including healthcare, employee management, e-commerce, meeting platforms, and wildlife management systems.",
      "Currently, I am expanding my expertise in Artificial Intelligence, Local LLMs, Voice AI, intelligent automation, and next-generation software solutions.",
      "I believe great software is not only functional but also intuitive, scalable, and impactful.",
    ];

    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 820;
    final double textFontSize = isMobile ? 15 : 17;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(paragraphs.length, (index) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: index == paragraphs.length - 1 ? 0 : 20,
          ),
          child:
              Text(
                    paragraphs[index],
                    style: TextStyle(
                      fontSize: textFontSize,
                      color: AppColors.white.withOpacity(0.9),
                      height: 1.8,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (index * 120).ms, duration: 600.ms)
                  .slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
        );
      }),
    );
  }
}

class _AboutStatsGrid extends StatelessWidget {
  const _AboutStatsGrid();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 820;

    final List<Widget> stats = const [
      _MetricCounter(endValue: 2, suffix: '+', label: 'Years Experience'),
      _MetricCounter(endValue: 5, suffix: '+', label: 'Projects Delivered'),
      _MetricCounter(endValue: 10, suffix: '+', label: 'Technologies Used'),
      _MetricCounter(
        endValue: 100,
        suffix: '%',
        label: 'Commitment to Quality',
      ),
    ];

    if (isMobile) {
      return Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: stats,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stats
          .map(
            (child) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: child,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _MetricCounter extends StatefulWidget {
  final int endValue;
  final String suffix;
  final String label;

  const _MetricCounter({
    required this.endValue,
    required this.suffix,
    required this.label,
  });

  @override
  State<_MetricCounter> createState() => _MetricCounterState();
}

class _MetricCounterState extends State<_MetricCounter>
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
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.endValue.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    if (!_hasAnimated) {
      _hasAnimated = true;
      if (mounted) {
        _controller.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _key,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05) {
          _startAnimation();
        }
      },
      child: Container(
        height: 100,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
          color: Colors.white.withOpacity(0.015),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  '${_animation.value.round()}${widget.suffix}',
                  style: const TextStyle(
                    color: Color(0xFFFF5A36),
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    letterSpacing: -0.5,
                  ),
                );
              },
            ),
            const SizedBox(height: 4),
            Text(
              widget.label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                height: 1.3,
                fontWeight: FontWeight.w600,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
