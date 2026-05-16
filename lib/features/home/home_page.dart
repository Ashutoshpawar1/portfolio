import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../utils/animated/custom_cursor.dart';
import '../../utils/animated/floating_circles.dart';
import '../../utils/components/brand_transition_panels.dart';
import '../../utils/components/menu_overlay.dart';
import '../../utils/components/site_footer.dart';
import '../../controllers/home_controller.dart';
import 'widgets/tool_wave_section.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_me_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';
import 'widgets/experience_section.dart';
import 'widgets/page_background.dart';

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
          final bool enableDesktopEffects = width >= 960;

          return MouseRegion(
            cursor: enableDesktopEffects
                ? SystemMouseCursors.progress
                : MouseCursor.defer,
            onHover: enableDesktopEffects
                ? (event) => controller.updateParallax(
                    event.position,
                    MediaQuery.of(context).size,
                  )
                : null,
            onExit: (_) => controller.resetParallax(),
            child: Stack(
              children: [
                PageBackground(enableMotion: enableDesktopEffects),
                if (enableDesktopEffects) const FloatingCircles(),
                NotificationListener<ScrollNotification>(
                  onNotification: enableDesktopEffects
                      ? (notification) {
                          controller.updateScroll(notification.metrics.pixels);
                          return false;
                        }
                      : (_) => false,
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: RepaintBoundary(
                      child: Column(
                        children: [
                          _sectionWrapper(
                            key: controller.heroSectionKey,
                            child: HeroSection(width: width),
                          ),
                          _sectionWrapper(
                            key: controller.aboutSectionKey,
                            color: AppColors.surface,
                            child: const AboutMeSection(),
                          ),
                          _sectionWrapper(
                            key: controller.projectsSectionKey,
                            color: AppColors.black,
                            child: const ProjectsSection(),
                          ),
                          _sectionWrapper(
                            key: controller.skillsSectionKey,
                            color: AppColors.surface,
                            child: const SkillsSection(),
                          ),
                          _sectionWrapper(
                            key: controller.experienceSectionKey,
                            color: AppColors.black,
                            child: const ExperienceSection(),
                          ),
                          _sectionWrapper(
                            key: controller.toolsSectionKey,
                            color: AppColors.surface,
                            child: const ToolWaveSection(),
                          ),
                          const SiteFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
                if (enableDesktopEffects) const CustomCursor(),
                Obx(
                  () => controller.isMenuOpen
                      ? MenuOverlay(
                          onClose: controller.closeMenu,
                          onNavigate: controller.startSectionTransition,
                        )
                      : const SizedBox.shrink(),
                ),
                Obx(
                  () => controller.isSectionTransitionVisible
                      ? Positioned.fill(
                          child: BrandTransitionOverlay(
                            label: "ASHUTOSH",
                            onReveal: controller.navigateToPendingSection,
                            onComplete: controller.finishSectionTransition,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _sectionWrapper({Key? key, required Widget child, Color? color}) {
    return RepaintBoundary(
      child: Container(
        key: key,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.04), width: 1),
          ),
        ),
        child: child,
      ),
    );
  }
}
