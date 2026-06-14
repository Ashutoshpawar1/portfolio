import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../routes/app_router.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/components/premium_button.dart';
import '../../../utils/components/resume_preview_dialog.dart';
import '../../../utils/components/social_links.dart';
import '../../../utils/components/section_divider_transition.dart';

class HeroSection extends StatelessWidget {
  final double width;

  const HeroSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    if (width < 720) {
      return _MobileHeroLayout(width: width);
    }

    if (width < 1180) {
      return _TabletHeroLayout(width: width);
    }

    return _DesktopHeroLayout(width: width);
  }
}

class _DesktopHeroLayout extends StatelessWidget {
  final double width;

  const _DesktopHeroLayout({required this.width});

  @override
  Widget build(BuildContext context) {
    final bool tightDesktop = width < 1450;
    final double horizontalPadding = width >= 1600 ? 42 : 28;
    final double heroImageSize = width >= 1600
        ? 440
        : (tightDesktop ? 300 : 360);
    final double watermarkSize = width >= 1600
        ? 150
        : (tightDesktop ? 112 : 126);
    final double introWidth = width >= 1600 ? 410 : (tightDesktop ? 360 : 390);
    final double sideWidth = width >= 1600 ? 310 : (tightDesktop ? 240 : 270);
    final double contentGap = tightDesktop ? 20 : 36;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          20,
          horizontalPadding,
          28,
        ),
        child: Column(
          children: [
            const _HeroTopBar(),
            const SizedBox(height: 18),
            Stack(
              children: [
                Positioned.fill(
                  child: _HeroFrameLines(
                    horizontalPadding: width >= 1600 ? 94 : 86,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeroWatermark(fontSize: watermarkSize),
                      const SizedBox(height: 22),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: introWidth),
                            child: _HeroIntroBlock(
                              headlineFontSize: tightDesktop ? 34 : 42,
                              bodyFontSize: tightDesktop ? 15 : 16,
                              contentSpacing: tightDesktop ? 12 : 16,
                              actionSpacing: tightDesktop ? 22 : 28,
                              socialSpacing: tightDesktop ? 22 : 28,
                            ),
                          ),
                          SizedBox(width: contentGap),
                          Expanded(
                            flex: 6,
                            child: Align(
                              alignment: Alignment.center,
                              child: _HeroVisualContent(size: heroImageSize),
                            ),
                          ),
                          SizedBox(width: contentGap),
                          Expanded(
                            flex: 4,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: sideWidth,
                                ),
                                child: _HeroSidePitch(
                                  titleFontSize: tightDesktop ? 32 : 38,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      const _HeroStatsRow(isCompact: false),
                      const SizedBox(height: 24),
                      const SectionDividerTransition(
                        label: "Explore About Me",
                        nextSection: HomeSection.about,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TabletHeroLayout extends StatelessWidget {
  final double width;

  const _TabletHeroLayout({required this.width});

  @override
  Widget build(BuildContext context) {
    final double horizontal = width < 900 ? 28 : 42;
    final double imageSize = width < 900 ? 300 : 340;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontal, 28, horizontal, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroTopBar(isCompact: true),
          const SizedBox(height: 28),
          _HeroWatermark(fontSize: width < 900 ? 108 : 132, compact: true),
          const SizedBox(height: 24),
          Center(child: _HeroVisualContent(size: imageSize)),
          const SizedBox(height: 36),
          const _HeroSidePitch(isCompact: true, centerAligned: true),
          const SizedBox(height: 36),
          const _HeroIntroBlock(isCompact: true, centered: true),
          const SizedBox(height: 40),
          const _HeroStatsRow(isCompact: true),
          const SizedBox(height: 20),
          const SectionDividerTransition(
            label: "Explore About Me",
            nextSection: HomeSection.about,
          ),
        ],
      ),
    );
  }
}

class _MobileHeroLayout extends StatelessWidget {
  final double width;

  const _MobileHeroLayout({required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 20 : 36,
        vertical: 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroTopBar(isCompact: true),
          const SizedBox(height: 24),
          _HeroWatermark(fontSize: width < 420 ? 88 : 102, compact: true),
          const SizedBox(height: 24),
          Center(child: _HeroVisualContent(size: width < 420 ? 230 : 260)),
          const SizedBox(height: 36),
          const _HeroSidePitch(isCompact: true),
          const SizedBox(height: 24),
          const _HeroIntroBlock(isCompact: true),
          const SizedBox(height: 40),
          const _HeroStatsRow(isCompact: true),
          const SizedBox(height: 20),
          const SectionDividerTransition(
            label: "Explore About Me",
            nextSection: HomeSection.about,
          ),
        ],
      ),
    );
  }
}

class _HeroTopBar extends StatelessWidget {
  final bool isCompact;

  const _HeroTopBar({this.isCompact = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    if (isCompact) {
      return SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeroLeftHeaderWidget(isCompact: true),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _HeaderButton(
                    label: "LET'S TALK",
                    onTap: () => context.push(AppRouter.contact),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _HeaderButton(
                    label: "MENU",
                    onTap: controller.toggleMenu,
                    isMenu: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const _HeroLeftHeaderWidget(isCompact: false),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeaderButton(
                  label: "LET'S TALK",
                  onTap: () => context.push(AppRouter.contact),
                ),
                const SizedBox(width: 12),
                _HeaderButton(
                  label: "MENU",
                  onTap: controller.toggleMenu,
                  isMenu: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroLeftHeaderWidget extends StatefulWidget {
  final bool isCompact;

  const _HeroLeftHeaderWidget({required this.isCompact});

  @override
  State<_HeroLeftHeaderWidget> createState() => _HeroLeftHeaderWidgetState();
}

class _HeroLeftHeaderWidgetState extends State<_HeroLeftHeaderWidget> {
  Timer? _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateTime();
        });
      }
    });
  }

  void _updateTime() {
    _currentTime = DateTime.now().toUtc().add(
      const Duration(hours: 5, minutes: 30),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final int hour = dt.hour;
    final int minute = dt.minute;
    final int second = dt.second;
    final String amPm = hour >= 12 ? 'PM' : 'AM';
    final int hour12 = hour % 12 == 0 ? 12 : hour % 12;

    final String hrStr = hour12.toString().padLeft(2, '0');
    final String minStr = minute.toString().padLeft(2, '0');
    final String secStr = second.toString().padLeft(2, '0');

    return '$hrStr:$minStr:$secStr $amPm';
  }

  @override
  Widget build(BuildContext context) {
    final String timeStr = _formatTime(_currentTime);

    if (widget.isCompact) {
      return Wrap(
        spacing: 12,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _PulsingGreenIndicator(),
              const SizedBox(width: 6),
              Text(
                "Available Now",
                style: TextStyle(
                  color: AppColors.emerald,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on_outlined, size: 12, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                "Indore, India",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.access_time, size: 12, color: AppColors.grey),
              const SizedBox(width: 4),
              Text(
                "$timeStr IST",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            "GMT +5:30",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _PulsingGreenIndicator(),
            const SizedBox(width: 8),
            Text(
              "Available Now",
              style: TextStyle(
                color: AppColors.emerald,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.location_on_outlined, size: 14, color: AppColors.grey),
            const SizedBox(width: 4),
            Text(
              "Indore, India",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 14),
            Icon(Icons.access_time, size: 14, color: AppColors.grey),
            const SizedBox(width: 4),
            Text(
              "$timeStr IST",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 14),
            Text(
              "GMT +5:30",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PulsingGreenIndicator extends StatefulWidget {
  const _PulsingGreenIndicator();

  @override
  State<_PulsingGreenIndicator> createState() => _PulsingGreenIndicatorState();
}

class _PulsingGreenIndicatorState extends State<_PulsingGreenIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.35, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.emerald.withOpacity(
                  0.35 * (1.0 - _pulseAnimation.value),
                ),
              ),
            ),
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.emerald,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.emerald.withOpacity(
                      0.5 * _pulseAnimation.value,
                    ),
                    blurRadius: 5 * _pulseAnimation.value,
                    spreadRadius: 1 * _pulseAnimation.value,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HeaderButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isMenu;

  const _HeaderButton({
    required this.label,
    required this.onTap,
    this.isMenu = false,
  });

  @override
  State<_HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<_HeaderButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final Color contentColor = _isHovered ? Colors.black : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 132,
          height: 46,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFF5A36)
                : Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered ? const Color(0xFFFF5A36) : AppColors.divider,
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF5A36).withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isMenu) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 14, height: 1.5, color: contentColor),
                    const SizedBox(height: 3.5),
                    Container(width: 14, height: 1.5, color: contentColor),
                  ],
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: contentColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroWatermark extends StatelessWidget {
  final bool compact;
  final double? fontSize;

  const _HeroWatermark({this.compact = false, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppStrings.logoText,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
        fontSize: fontSize ?? (compact ? 82 : 186),
        color: Colors.white.withOpacity(compact ? 0.82 : 0.74),
        height: 0.9,
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: -0.05);
  }
}

class _HeroIntroBlock extends StatelessWidget {
  final bool isCompact;
  final bool centered;
  final double? headlineFontSize;
  final double? bodyFontSize;
  final double contentSpacing;
  final double actionSpacing;
  final double socialSpacing;

  const _HeroIntroBlock({
    this.isCompact = false,
    this.centered = false,
    this.headlineFontSize,
    this.bodyFontSize,
    this.contentSpacing = 16,
    this.actionSpacing = 28,
    this.socialSpacing = 28,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final TextAlign textAlign = centered ? TextAlign.center : TextAlign.start;
    final CrossAxisAlignment crossAxisAlignment = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              "ASHUTOSH GARGE",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: headlineFontSize ?? (isCompact ? 32 : 44),
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                height: 0.94,
              ),
              textAlign: textAlign,
            ),
            const SizedBox(height: 12),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.white.withOpacity(0.9),
                fontSize: isCompact ? 16 : 20,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Flutter Developer Building Scalable Mobile Apps, and AI-Powered Digital Experiences.",
                    speed: const Duration(milliseconds: 25),
                    textAlign: textAlign,
                    cursor: ' _',
                  ),
                ],
              ),
            ),
            SizedBox(height: contentSpacing),
            Text(
              "With 2+ years of experience developing production-ready Flutter applications, I specialize in scalable architectures, real-time communication systems, API integrations, Firebase solutions, and AI-powered experiences.\n\nFocused on performance, clean architecture, maintainability, and exceptional user experiences.",
              style: TextStyle(
                fontSize: bodyFontSize ?? (isCompact ? 14 : 15),
                color: AppColors.grey,
                height: 1.6,
              ),
              textAlign: textAlign,
            ),
            SizedBox(height: actionSpacing),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: centered ? WrapAlignment.center : WrapAlignment.start,
              children: [
                PremiumButton(
                  label: AppStrings.viewProjects,
                  onTap: () =>
                      controller.navigateToSection(HomeSection.projects),
                ),
                PremiumButton(
                  label: AppStrings.downloadResume,
                  onTap: () => ResumePreviewDialog.show(context),
                  isPrimary: false,
                  icon: Icons.download,
                ),
              ],
            ),
            SizedBox(height: socialSpacing),
            const SocialLinks(),
          ],
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }
}

class _HeroSidePitch extends StatelessWidget {
  final bool isCompact;
  final bool centerAligned;
  final double? titleFontSize;

  const _HeroSidePitch({
    this.isCompact = false,
    this.centerAligned = false,
    this.titleFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final TextAlign align = centerAligned
        ? TextAlign.center
        : (isCompact ? TextAlign.start : TextAlign.right);

    final List<String> specialties = [
      "Flutter Development",
      "Firebase & Backend Integration",
      "AI-Powered Applications",
      "Socket.IO Real-Time Systems",
      "Clean Architecture (GetX / BLoC)",
      "Performance Optimization",
      "Responsive UI Engineering",
    ];

    return Column(
          crossAxisAlignment: centerAligned
              ? CrossAxisAlignment.center
              : (isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.end),
          children: [
            Text(
              isCompact
                  ? "SCALABLE. MODERN. INTELLIGENT."
                  : "SCALABLE\nMODERN\nINTELLIGENT",
              textAlign: align,
              style: TextStyle(
                fontSize: titleFontSize ?? (isCompact ? 28 : 42),
                fontWeight: FontWeight.w900,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 1.5,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 24),
            ...specialties.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: centerAligned
                      ? MainAxisAlignment.center
                      : (isCompact
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end),
                  children: [
                    if (centerAligned || isCompact) ...[
                      const Icon(
                        Icons.circle,
                        size: 6,
                        color: Color(0xFFFF5A36),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      item,
                      textAlign: align,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: isCompact ? 13 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (!centerAligned && !isCompact) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.circle,
                        size: 6,
                        color: Color(0xFFFF5A36),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 1000.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }
}

class _HeroFrameLines extends StatelessWidget {
  final double horizontalPadding;

  const _HeroFrameLines({this.horizontalPadding = 120});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 1, color: Colors.white.withOpacity(0.05)),
            Container(width: 1, color: Colors.white.withOpacity(0.05)),
          ],
        ),
      ),
    );
  }
}

class _HeroVisualContent extends StatelessWidget {
  final double size;

  const _HeroVisualContent({this.size = 400});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(
      () => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(controller.parallaxX * 0.08)
          ..rotateX(-controller.parallaxY * 0.05)
          ..translate(controller.parallaxX * 24, controller.parallaxY * 18),
        alignment: Alignment.center,
        child:
            Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Glowing background circle
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFF5A36).withOpacity(0.14),
                              Colors.transparent,
                            ],
                            radius: 0.65,
                          ),
                        ),
                      ),
                    ),
                    // Profile image container
                    RepaintBoundary(
                          child: Container(
                            width: size,
                            height: size * 1.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.12),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.42),
                                  blurRadius: 60,
                                  offset: const Offset(0, 24),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.asset(
                                    'lib/assets/images/ashu_profile.png',
                                    fit: BoxFit.cover,
                                  ),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.black.withOpacity(0.4),
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.3),
                                        ],
                                        stops: const [0.05, 0.45, 1],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: -8,
                          end: 8,
                          duration: 3000.ms,
                          curve: Curves.easeInOut,
                        ),
                    // Floating Card 1 (Top Left)
                    Positioned(
                          left: -32,
                          top: size * 0.15,
                          child: const _FloatingCard(
                            emoji: "🚀",
                            title: "5+ Projects",
                            subtitle: "Delivered",
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: 4,
                          end: -6,
                          duration: 2500.ms,
                          curve: Curves.easeInOut,
                        ),
                    // Floating Card 2 (Bottom Right)
                    Positioned(
                          right: -32,
                          bottom: size * 0.15,
                          child: const _FloatingCard(
                            emoji: "🤖",
                            title: "AI Integration",
                            subtitle: "Specialist",
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: -6,
                          end: 4,
                          duration: 2700.ms,
                          curve: Curves.easeInOut,
                        ),
                  ],
                )
                .animate()
                .fadeIn(duration: 900.ms)
                .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
      ),
    );
  }
}

class _FloatingCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;

  const _FloatingCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnimatedCounter extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String label;

  const _AnimatedCounter({
    required this.targetValue,
    required this.suffix,
    required this.label,
  });

  @override
  State<_AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<_AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.targetValue.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int val = _animation.value.round();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$val${widget.suffix}",
              style: const TextStyle(
                color: Color(0xFFFF5A36),
                fontSize: 36,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.55),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _HeroStatsRow extends StatelessWidget {
  final bool isCompact;

  const _HeroStatsRow({required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [
      const _AnimatedCounter(
        targetValue: 5,
        suffix: "+",
        label: "PROJECTS DELIVERED",
      ),
      const _AnimatedCounter(
        targetValue: 2,
        suffix: "+",
        label: "YEARS EXPERIENCE",
      ),
      const _AnimatedCounter(
        targetValue: 100,
        suffix: "%",
        label: "COMMITMENT",
      ),
    ];

    if (isCompact) {
      return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Wrap(
              spacing: 40,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: items,
            ),
          )
          .animate()
          .fadeIn(duration: 1100.ms)
          .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
    }

    return Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          ),
        )
        .animate()
        .fadeIn(duration: 1100.ms)
        .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
  }
}
