import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/skill_progress_bar.dart';
import '../../../utils/components/glass_container.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 980;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 160,
        horizontal: width < 720 ? 18 : 40,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        image: DecorationImage(
          image: const NetworkImage(
            "https://www.transparenttextures.com/patterns/carbon-fibre.png", // Subtle noise/texture
          ),
          opacity: 0.03,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.skills),
          const SizedBox(height: 90),
          LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: [
                  _SkillCategoryCard(
                    title: "Mobile Stack",
                    accentColor: const Color(0xFF6366F1), // Blue-Purple
                    skills: const [
                      _SkillData(
                        "Flutter Architecture",
                        0.95,
                        Icons.flutter_dash,
                      ),
                      _SkillData(
                        "Material 3 / UI Design",
                        0.92,
                        Icons.brush_rounded,
                      ),
                      _SkillData(
                        "GetX / State Management",
                        0.95,
                        Icons.account_tree_outlined,
                      ),
                      _SkillData(
                        "Native Integration",
                        0.85,
                        Icons.settings_cell_rounded,
                      ),
                    ],
                    width: isMobile
                        ? constraints.maxWidth
                        : (constraints.maxWidth - 60) / 2,
                  ),
                  _SkillCategoryCard(
                    title: "Services & Web",
                    accentColor: const Color(0xFF10B981), // Emerald
                    skills: const [
                      _SkillData(
                        "Firebase / Supabase",
                        0.88,
                        Icons.local_fire_department_rounded,
                      ),
                      _SkillData(
                        "Node.js Backend",
                        0.75,
                        Icons.terminal_rounded,
                      ),
                      _SkillData("REST API Design", 0.82, Icons.api_rounded),
                      _SkillData(
                        "Cloud Infrastructure",
                        0.78,
                        Icons.cloud_queue_rounded,
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
        scale: _isHovered ? 1.015 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: widget.width.clamp(320, 620),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.accentColor.withOpacity(0.18),
                  blurRadius: 40,
                  spreadRadius: 2,
                  offset: const Offset(0, 15),
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
                    Container(
                      width: 4,
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
                      style: const TextStyle(
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
                      .fadeIn(delay: (200 + (index * 100)).ms, duration: 600.ms)
                      .slideX(begin: 0.1, curve: Curves.easeOutCubic);
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
