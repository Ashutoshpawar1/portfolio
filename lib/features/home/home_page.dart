import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../utils/animated/custom_cursor.dart';
import '../../utils/animated/floating_circles.dart';
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

          return MouseRegion(
            cursor: SystemMouseCursors.none,
            onHover: (event) => controller.updateParallax(
              event.position,
              MediaQuery.of(context).size,
            ),
            onExit: (_) => controller.resetParallax(),
            child: Stack(
              children: [
                const PageBackground(),
                const FloatingCircles(),
                NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    controller.updateScroll(notification.metrics.pixels);
                    return false;
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _sectionWrapper(child: HeroSection(width: width)),
                      _sectionWrapper(
                        color: AppColors.surface,
                        child: const AboutMeSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.black,
                        child: const ProjectsSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.surface,
                        child: const SkillsSection(),
                      ),
                      _sectionWrapper(
                        color: AppColors.black,
                        child: const ExperienceSection(),
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
