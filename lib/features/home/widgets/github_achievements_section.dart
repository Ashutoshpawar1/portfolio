import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/scroll_reveal.dart';
import '../../../utils/services/external_link_service.dart';

class GithubAchievementsSection extends StatelessWidget {
  const GithubAchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 980;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: width < 720 ? 18 : 40,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: "GitHub & Achievements"),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Open source contributions, continuous learning, and technical milestones that shape my developer journey.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withOpacity(0.92),
                fontSize: width < 720 ? 16 : 18,
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 64),
          ScrollReveal(
            child: Wrap(
              spacing: 32,
              runSpacing: 32,
              alignment: WrapAlignment.center,
              children: [
                _buildGithubCard(isMobile),
                _buildAchievementsCard(isMobile),
              ],
            ),
          ),
          const SizedBox(height: 48),
          ScrollReveal(child: _buildContributionGraph(isMobile)),
        ],
      ),
    );
  }

  Widget _buildGithubCard(bool isMobile) {
    return _HoverCard(
      width: isMobile ? double.infinity : 480,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.code_rounded, color: AppColors.orange, size: 32),
              const SizedBox(width: 16),
              const Text(
                "GitHub Overview",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.open_in_new_rounded,
                  color: AppColors.grey,
                ),
                onPressed: () => openExternalUrl(AppStrings.githubUrl),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _StatRow(
            label: "Repositories",
            value: "35+",
            icon: Icons.book_rounded,
          ),
          const SizedBox(height: 16),
          _StatRow(
            label: "Total Commits",
            value: "1.2k+",
            icon: Icons.commit_rounded,
          ),
          const SizedBox(height: 16),
          _StatRow(
            label: "Open Source PRs",
            value: "10+",
            icon: Icons.merge_type_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsCard(bool isMobile) {
    return _HoverCard(
      width: isMobile ? double.infinity : 480,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.emoji_events_rounded,
                color: Colors.amber,
                size: 32,
              ),
              const SizedBox(width: 16),
              const Text(
                "Key Achievements",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _AchievementRow(text: "Top Rated Plus on Upwork"),
          const SizedBox(height: 16),
          _AchievementRow(text: "Led migration of 5+ legacy apps to Flutter"),
          const SizedBox(height: 16),
          _AchievementRow(text: "Mentored 10+ junior developers"),
        ],
      ),
    );
  }

  Widget _buildContributionGraph(bool isMobile) {
    return _HoverCard(
      width: isMobile ? double.infinity : 992,
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_graph_rounded,
                color: Colors.greenAccent,
                size: 28,
              ),
              const SizedBox(width: 16),
              const Text(
                "713 contributions in the last year",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (!isMobile)
                const Text(
                  "Contribution settings ▾",
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'lib/assets/images/github_contribution.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;

  const _HoverCard({required this.child, this.width, required this.padding});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppColors.orange.withOpacity(0.4)
                  : AppColors.divider,
            ),
            color: AppColors.surface,
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors.orange.withOpacity(0.12),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
            ],
          ),
          padding: widget.padding,
          child: widget.child,
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(color: AppColors.grey, fontSize: 16),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final String text;

  const _AchievementRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.verified_rounded,
            color: Colors.greenAccent,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _ContributionGrid extends StatelessWidget {
  const _ContributionGrid();

  @override
  Widget build(BuildContext context) {
    const double gridWidth = 52 * 16.0;
    const double daysColumnWidth = 32.0;
    const double totalWidth = gridWidth + daysColumnWidth;
    final bool isMobile = MediaQuery.of(context).size.width < 980;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: daysColumnWidth),
                      ...List.generate(12, (index) {
                        const months = [
                          "Sep",
                          "Oct",
                          "Nov",
                          "Dec",
                          "Jan",
                          "Feb",
                          "Mar",
                          "Apr",
                          "May",
                          "Jun",
                          "Jul",
                          "Aug",
                        ];
                        return Container(
                          width: gridWidth / 12.0,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            months[index],
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: List.generate(7, (index) {
                          String label = "";
                          if (index == 1) label = "Mon";
                          if (index == 3) label = "Wed";
                          if (index == 5) label = "Fri";
                          return Container(
                            height: 12,
                            width: daysColumnWidth - 8,
                            margin: const EdgeInsets.only(
                              bottom: 4.0,
                              right: 8.0,
                            ),
                            alignment: Alignment.centerRight,
                            child: Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }),
                      ),
                      Row(
                        children: List.generate(52, (colIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Column(
                              children: List.generate(7, (rowIndex) {
                                int level = _getContributionLevel(
                                  colIndex,
                                  rowIndex,
                                );
                                return Container(
                                  width: 12,
                                  height: 12,
                                  margin: const EdgeInsets.only(bottom: 4.0),
                                  decoration: BoxDecoration(
                                    color: _getColorForLevel(level),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: totalWidth,
                    child: Row(
                      children: [
                        const SizedBox(width: daysColumnWidth),
                        const Text(
                          "Learn how we count contributions",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const Spacer(),
                        const Text(
                          "Less",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(width: 8),
                        _buildLegendBox(0),
                        _buildLegendBox(1),
                        _buildLegendBox(2),
                        _buildLegendBox(3),
                        _buildLegendBox(4),
                        const SizedBox(width: 4),
                        const Text(
                          "More",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (!isMobile)
          Container(
            width: 120,
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Column(
              children: [
                _buildYearButton("2026", true),
                const SizedBox(height: 8),
                _buildYearButton("2025", false),
                const SizedBox(height: 8),
                _buildYearButton("2024", false),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildYearButton(String year, bool isSelected) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2F81F7) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        year,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white54,
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildLegendBox(int level) {
    return Container(
      width: 12,
      height: 12,
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: _getColorForLevel(level),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  int _getContributionLevel(int col, int row) {
    int hash = (col * 23 + row * 17) % 100;
    if (hash < 60) return 0;
    if (hash < 75) return 1;
    if (hash < 88) return 2;
    if (hash < 95) return 3;
    return 4;
  }

  Color _getColorForLevel(int level) {
    switch (level) {
      case 1:
        return const Color(0xFF0E4429);
      case 2:
        return const Color(0xFF006D32);
      case 3:
        return const Color(0xFF26A641);
      case 4:
        return const Color(0xFF39D353);
      case 0:
      default:
        return const Color(0xFF161B22);
    }
  }
}
