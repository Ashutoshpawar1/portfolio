import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../routes/app_router.dart';
import '../../utils/animated/custom_cursor.dart';
import '../../utils/animated/floating_circles.dart';
import '../../utils/components/top_menu_button.dart';
import '../../utils/components/menu_overlay.dart';
import '../../utils/components/skill_progress_bar.dart';
import '../../utils/components/animated_section_title.dart';
import '../../utils/components/premium_button.dart';
import '../../utils/components/social_links.dart';
import '../../utils/components/project_card.dart';
import '../../utils/components/site_footer.dart';
import '../../utils/components/timeline_item.dart';
import '../../controllers/home_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'widgets/tool_wave_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;

          return MouseRegion(
            cursor: SystemMouseCursors.none,
            onHover: (event) => controller.updateParallax(
              event.position,
              MediaQuery.of(context).size,
            ),
            onExit: (_) => controller.resetParallax(),
            child: Stack(
              children: [
                const _PageBackground(),
                const FloatingCircles(),
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    controller.updateScroll(notification.metrics.pixels);
                    return false;
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _sectionWrapper(child: _HeroSection(width: width)),
                      _sectionWrapper(
                        color: AppColors.surface,
                        child: const _AboutMeSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.black,
                        child: const _ProjectsSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.surface,
                        child: const _SkillsSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.black,
                        child: const _ExperienceSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.surface,
                        child: const ToolWaveSection(),
                      ),
                      const SiteFooter(),
                    ],
                  ),
                ),
                const CustomCursor(),
                Obx(
                  () => controller.isMenuOpen
                      ? MenuOverlay(onClose: controller.toggleMenu)
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionWrapper({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
        ),
      ),
      child: child,
    );
  }
}

class _PageBackground extends StatelessWidget {
  const _PageBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF080808), Color(0xFF030303)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -180,
            left: -120,
            child: Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.03),
              ),
            ),
          ),
          Positioned(
            right: -80,
            bottom: 220,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.02),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final double width;

  const _HeroSection({required this.width});

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
        ? 470
        : (tightDesktop ? 330 : 390);
    final double watermarkSize = width >= 1600
        ? 150
        : (tightDesktop ? 112 : 126);
    final double introWidth = width >= 1600 ? 380 : (tightDesktop ? 420 : 340);
    final double sideWidth = width >= 1600 ? 280 : (tightDesktop ? 210 : 230);
    final double contentGap = tightDesktop ? 28 : 40;

    return SizedBox(
      height: MediaQuery.of(context).size.height.clamp(760.0, 980.0),
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
            Expanded(
              child: Stack(
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
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: introWidth,
                                ),
                                child: _HeroIntroBlock(
                                  headlineFontSize: tightDesktop ? 30 : 36,
                                  bodyFontSize: tightDesktop ? 16 : 18,
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
                                  child: _HeroVisualContent(
                                    size: heroImageSize,
                                  ),
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
                                      titleFontSize: tightDesktop ? 62 : 74,
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
                ],
              ),
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
    final double imageSize = width < 900 ? 340 : 390;

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontal, 28, horizontal, 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeroTopBar(isCompact: true),
          const SizedBox(height: 28),
          _HeroWatermark(fontSize: width < 900 ? 108 : 132, compact: true),
          const SizedBox(height: 24),
          Center(child: _HeroVisualContent(size: imageSize)),
          const SizedBox(height: 28),
          const _HeroSidePitch(isCompact: true, centerAligned: true),
          const SizedBox(height: 28),
          const _HeroIntroBlock(isCompact: true, centered: true),
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
          Center(child: _HeroVisualContent(size: width < 420 ? 260 : 290)),
          const SizedBox(height: 28),
          const _HeroSidePitch(isCompact: true),
          const SizedBox(height: 24),
          const _HeroIntroBlock(isCompact: true),
          const SizedBox(height: 28),
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
            const _StatusChip(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: PremiumButton(
                    label: AppStrings.contactMe,
                    onTap: () => context.push(AppRouter.contact),
                    isPrimary: false,
                    enableShine: true,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: TopMenuButton(
                    label: AppStrings.menu,
                    onTap: controller.toggleMenu,
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
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
        child: Row(
          children: [
            const _StatusChip(),
            const Spacer(),
            const Text(
              "ASHUTOSH PORTFOLIO",
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PremiumButton(
                  label: AppStrings.contactMe,
                  onTap: () => context.push(AppRouter.contact),
                  isPrimary: false,
                  enableShine: true,
                ),
                const SizedBox(width: 12),
                TopMenuButton(
                  label: AppStrings.menu,
                  onTap: controller.toggleMenu,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
        color: AppColors.white.withOpacity(0.02),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 10, color: AppColors.emerald),
          SizedBox(width: 8),
          Text(
            "Available for project",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "Flutter developer focused on polished mobile and web products.",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: headlineFontSize ?? (isCompact ? 24 : 36),
            fontWeight: FontWeight.w700,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        ),
        SizedBox(height: contentSpacing),
        Text(
          AppStrings.devDescriptionLong,
          style: TextStyle(
            fontSize: bodyFontSize ?? (isCompact ? 16 : 18),
            color: AppColors.grey,
            height: 1.7,
          ),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        ),
        SizedBox(height: actionSpacing),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PremiumButton(label: AppStrings.viewProjects, onTap: () {}),
            PremiumButton(
              label: AppStrings.downloadResume,
              onTap: () {},
              isPrimary: false,
              icon: Icons.download,
            ),
          ],
        ),
        SizedBox(height: socialSpacing),
        const SocialLinks(),
      ],
    ).animate().fadeIn(delay: 250.ms, duration: 700.ms).slideY(begin: 0.08);
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
    return Column(
      crossAxisAlignment: centerAligned
          ? CrossAxisAlignment.center
          : (isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.end),
      children: [
        Text(
          "Beyond Flutter.\nBuilt with Vision.",
          textAlign: centerAligned
              ? TextAlign.center
              : (isCompact ? TextAlign.start : TextAlign.right),
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            fontSize: titleFontSize ?? (isCompact ? 52 : 74),
            color: Colors.white.withOpacity(0.78),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          AppStrings.devSubtitle,
          textAlign: centerAligned
              ? TextAlign.center
              : (isCompact ? TextAlign.start : TextAlign.right),
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        ),
      ],
    ).animate().fadeIn(delay: 350.ms).slideX(begin: isCompact ? 0 : 0.08);
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
            Container(
                  width: size,
                  height: size * 1.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.42),
                        blurRadius: 60,
                        offset: const Offset(0, 24),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
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
                )
                .animate()
                .fadeIn(duration: 900.ms)
                .scale(begin: const Offset(0.96, 0.96)),
      ),
    );
  }
}

class _AboutMeSection extends StatelessWidget {
  const _AboutMeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 32),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.aboutTitle),
          const SizedBox(height: 70),
          ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Text(
                  AppStrings.aboutContent,
                  style: const TextStyle(
                    fontSize: 22,
                    color: AppColors.white,
                    height: 1.8,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 800))
              .slideY(begin: 0.1),
        ],
      ),
    );
  }
}

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.projectsTitle),
          const SizedBox(height: 70),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: width < 720 ? 20 : 32),
            clipBehavior: Clip.none,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: appProjects
                  .map((p) => ProjectCard(project: p))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  const _SkillsSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 150,
        horizontal: width < 720 ? 20 : 32,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.skills),
          const SizedBox(height: 80),
          Wrap(
            spacing: 120,
            runSpacing: 60,
            alignment: WrapAlignment.center,
            children: [
              _buildSkillColumn("Mobile Stack", const [
                SkillProgressBar(skill: "Flutter Architecture", progress: 0.95),
                SkillProgressBar(
                  skill: "Material 3 / UI Design",
                  progress: 0.9,
                ),
                SkillProgressBar(
                  skill: "GetX / State Management",
                  progress: 0.95,
                ),
              ]),
              _buildSkillColumn("Services & Web", const [
                SkillProgressBar(skill: "Firebase / Supabase", progress: 0.85),
                SkillProgressBar(skill: "Node.js Backend", progress: 0.7),
                SkillProgressBar(skill: "REST API Design", progress: 0.8),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillColumn(String title, List<Widget> bars) {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 40),
          ...bars.expand((b) => [b, const SizedBox(height: 30)]),
        ],
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 150,
        horizontal: width < 720 ? 20 : 32,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.experience),
          const SizedBox(height: 80),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: const Column(
              children: [
                TimelineItem(
                  role: "Senior Flutter Architect",
                  company: "High-Tech Innovations",
                  duration: "2022 - Present",
                  description:
                      "Engineering scalable mobile architectures for complex enterprise systems. Specializing in real-time communication and custom UI ecosystems.",
                ),
                TimelineItem(
                  role: "Flutter Developer",
                  company: "Creative Labs",
                  duration: "2020 - 2022",
                  description:
                      "Built interactive educational and service-based applications with focus on animations and user experience.",
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
