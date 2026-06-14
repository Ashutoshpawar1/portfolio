import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:marquee/marquee.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/glass_container.dart';
import '../../../utils/components/scroll_reveal.dart';
import '../../../utils/components/skill_progress_bar.dart';
import '../../../utils/components/section_divider_transition.dart';
import '../../../controllers/home_controller.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const String _technologyLine =
      'Flutter   |   Dart   |   Flutter Web   |   Responsive UI   |   GetX   |   Riverpod   |   Bloc   |   REST APIs   |   Node.js   |   Express.js   |   MongoDB   |   Socket.io   |   Jitsi Meet   |   Twilio   |   ChatGPT   |   Claude   |   Gemini   |   Ollama   |   Gamma AI';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 980;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 150,
        horizontal: width < 720 ? 18 : 40,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withOpacity(0.015),
            Colors.transparent,
            Colors.white.withOpacity(0.01),
          ],
        ),
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.skills),
          const SizedBox(height: 32),
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            from: 24,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                'Performance-first frontend engineering with responsive UI systems, state management, scalable architecture, and real-time service integration.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.grey.withOpacity(0.92),
                  fontSize: width < 720 ? 16 : 18,
                  height: 1.7,
                ),
              ),
            ),
          ),
          const SizedBox(height: 70),
          ScrollReveal(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  spacing: 40,
                  runSpacing: 40,
                  alignment: WrapAlignment.center,
                  children: [
                    _SkillCategoryCard(
                      title: "Mobile Stack",
                      accentColor: const Color(0xFF6366F1),
                      skills: const [
                        _SkillData("Flutter", 0.95, Icons.flutter_dash),
                        _SkillData(
                          "Flutter Web / Responsive UI",
                          0.92,
                          Icons.brush_rounded,
                        ),
                        _SkillData(
                          "Pixel-perfect UI",
                          0.93,
                          Icons.crop_free_rounded,
                        ),
                        _SkillData(
                          "Animation Integration",
                          0.88,
                          Icons.animation_rounded,
                        ),
                        _SkillData(
                          "Production Architecture",
                          0.90,
                          Icons.account_tree_outlined,
                        ),
                      ],
                      width: isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 60) / 2,
                    ),
                    _SkillCategoryCard(
                      title: "State & APIs",
                      accentColor: const Color(0xFF10B981),
                      skills: const [
                        _SkillData(
                          "GetX (Advanced)",
                          0.95,
                          Icons.account_tree_outlined,
                        ),
                        _SkillData(
                          "Riverpod / Bloc",
                          0.76,
                          Icons.layers_rounded,
                        ),
                        _SkillData("REST APIs", 0.88, Icons.api_rounded),
                        _SkillData(
                          "Authentication & CRUD",
                          0.85,
                          Icons.verified_user_rounded,
                        ),
                        _SkillData(
                          "Third-party Integrations",
                          0.86,
                          Icons.extension_rounded,
                        ),
                      ],
                      width: isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 60) / 2,
                    ),
                    _SkillCategoryCard(
                      title: "Realtime & Tools",
                      accentColor: const Color(0xFFF97316),
                      skills: const [
                        _SkillData(
                          "Socket.io / Twilio / Jitsi",
                          0.78,
                          Icons.hub_rounded,
                        ),
                        _SkillData(
                          "Notifications / WhatsApp",
                          0.74,
                          Icons.notifications_active_rounded,
                        ),
                        _SkillData(
                          "Node.js / Express / MongoDB",
                          0.76,
                          Icons.storage_rounded,
                        ),
                        _SkillData(
                          "ChatGPT / Claude / Gemini",
                          0.86,
                          Icons.auto_awesome_rounded,
                        ),
                      ],
                      width: isMobile
                          ? constraints.maxWidth
                          : (constraints.maxWidth - 60) / 2,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 52),
          ScrollReveal(
            beginOffset: const Offset(0, 0.05),
            child: Container(
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: AppColors.divider),
                color: Colors.white.withOpacity(0.03),
              ),
              child: Marquee(
                text: _technologyLine,
                velocity: 42,
                blankSpace: 120,
                pauseAfterRound: const Duration(milliseconds: 400),
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          const SectionDividerTransition(
            label: "Explore Experience",
            nextSection: HomeSection.experience,
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final String title;
  final List<_SkillData> skills;
  final Color accentColor;
  final double width;

  const _SkillCategoryCard({
    required this.title,
    required this.skills,
    required this.accentColor,
    required this.width,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.018 : 1.0,
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 360),
          width: widget.width.clamp(320.0, 620.0).toDouble(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.2),
                  blurRadius: 42,
                  spreadRadius: 2,
                  offset: const Offset(0, 18),
                ),
            ],
          ),
          child: GlassContainer(
            borderRadius: 30,
            blur: 14,
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      width: _isHovered ? 40 : 4,
                      height: 32,
                      decoration: BoxDecoration(
                        color: widget.accentColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: widget.accentColor.withOpacity(0.5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 28,
                        color: AppColors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                ...List.generate(widget.skills.length, (index) {
                  final skill = widget.skills[index];
                  return Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: SkillProgressBar(
                          skill: skill.name,
                          progress: skill.progress,
                          icon: skill.icon,
                          accentColor: widget.accentColor,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (180 + (index * 90)).ms, duration: 560.ms)
                      .slideX(begin: 0.08, curve: Curves.easeOutCubic);
                }),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.05);
  }
}

class _SkillData {
  final String name;
  final double progress;
  final IconData icon;

  const _SkillData(this.name, this.progress, this.icon);
}
