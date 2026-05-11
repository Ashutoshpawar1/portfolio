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
import '../../../utils/components/top_menu_button.dart';
import '../../../utils/components/social_links.dart';

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
        ? 470
        : (tightDesktop ? 330 : 390);
    final double watermarkSize = width >= 1600
        ? 150
        : (tightDesktop ? 112 : 126);
    final double introWidth = width >= 1600 ? 380 : (tightDesktop ? 420 : 340);
    final double sideWidth = width >= 1600 ? 280 : (tightDesktop ? 210 : 230);
    final double contentGap = tightDesktop ? 28 : 40;

    return SizedBox(
      height: MediaQuery.of(context).size.height.clamp(760.0, 980.0).toDouble(),
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
    final controller = Get.find<HomeController>();
    final List<String> lines = AppStrings.heroIdentityTitle.split('\n');
    final String primaryLine = lines.isNotEmpty ? lines.first : AppStrings.heroIdentityTitle;
    final String animatedLine = lines.length > 1 ? lines.sublist(1).join(' ') : '';
    final TextAlign textAlign = centered ? TextAlign.center : TextAlign.start;
    final CrossAxisAlignment crossAxisAlignment = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return FadeInLeft(
      duration: 700.ms,
      from: 36,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            primaryLine,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: headlineFontSize ?? (isCompact ? 24 : 36),
              fontWeight: FontWeight.w700,
            ),
            textAlign: textAlign,
          ),
          if (animatedLine.isNotEmpty) ...[
            const SizedBox(height: 10),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.white.withOpacity(0.9),
                fontSize: isCompact ? 18 : 22,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                isRepeatingAnimation: false,
                displayFullTextOnTap: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    animatedLine,
                    speed: const Duration(milliseconds: 40),
                    textAlign: textAlign,
                    cursor: ' _',
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: contentSpacing),
          Text(
            AppStrings.devDescriptionLong,
            style: TextStyle(
              fontSize: bodyFontSize ?? (isCompact ? 16 : 18),
              color: AppColors.grey,
              height: 1.7,
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
                onTap: () => controller.navigateToSection(HomeSection.projects),
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
      ),
    );
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
    final CrossAxisAlignment crossAxisAlignment = centerAligned
        ? CrossAxisAlignment.center
        : (isCompact ? CrossAxisAlignment.start : CrossAxisAlignment.end);

    return FadeInRight(
      duration: 800.ms,
      from: 42,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Text(
            AppStrings.heroSpecialtiesTitle,
            textAlign: align,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontSize: titleFontSize ?? (isCompact ? 52 : 74),
              color: Colors.white.withOpacity(0.78),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            AppStrings.devSubtitle,
            textAlign: align,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
          ),
        ],
      ),
    );
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
        child: FadeInUp(
          duration: 850.ms,
          from: 34,
          child: RepaintBoundary(
                child: Container(
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
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .moveY(begin: -8, end: 8, duration: 3000.ms, curve: Curves.easeInOut)
              .then()
              .moveY(begin: 8, end: -8, duration: 3000.ms, curve: Curves.easeInOut),
        ),
      ),
    );
  }
}
