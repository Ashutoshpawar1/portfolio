import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_strings.dart';
import '../../../controllers/app_cursor_controller.dart';
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
          const AnimatedSectionTitle(title: "GitHub Overview"),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Open source contributions, continuous learning, and technical milestones that shape my developer journey.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withValues(alpha: 0.92),
                fontSize: width < 720 ? 16 : 18,
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 64),
          ScrollReveal(child: _buildUnifiedContributionCard(isMobile)),
        ],
      ),
    );
  }

  Widget _buildUnifiedContributionCard(bool isMobile) {
    return _HoverCard(
      width: isMobile ? double.infinity : 992,
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Header Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_graph_rounded,
                  color: AppColors.emerald,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  "713 contributions in the last year",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: isMobile ? 16 : 20,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              const _GithubLinkButton(),
            ],
          ),
          const SizedBox(height: 28),
          // Contribution Graph Graphic
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              borderRadius: BorderRadius.circular(14),
              color: Colors.black.withValues(alpha: 0.25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                'lib/assets/images/github_contribution.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Divider
          Container(
            height: 1,
            width: double.infinity,
            color: AppColors.divider,
          ),
          const SizedBox(height: 28),
          // GitHub Overview Keys on the Down Side
          if (isMobile)
            Column(
              children: [
                _StatBox(
                  icon: Icons.book_rounded,
                  label: "Repositories",
                  value: "35+",
                  accentColor: AppColors.orange,
                  onTap: () => openExternalUrl(AppStrings.githubUrl),
                ),
                const SizedBox(height: 12),
                _StatBox(
                  icon: Icons.commit_rounded,
                  label: "Total Commits",
                  value: "1.2k+",
                  accentColor: AppColors.emerald,
                  onTap: () => openExternalUrl(AppStrings.githubUrl),
                ),
                const SizedBox(height: 12),
                _StatBox(
                  icon: Icons.merge_type_rounded,
                  label: "Open Source PRs",
                  value: "10+",
                  accentColor: const Color(0xFF64B5F6),
                  onTap: () => openExternalUrl(AppStrings.githubUrl),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    icon: Icons.book_rounded,
                    label: "Repositories",
                    value: "35+",
                    accentColor: AppColors.orange,
                    onTap: () => openExternalUrl(AppStrings.githubUrl),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatBox(
                    icon: Icons.commit_rounded,
                    label: "Total Commits",
                    value: "1.2k+",
                    accentColor: AppColors.emerald,
                    onTap: () => openExternalUrl(AppStrings.githubUrl),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatBox(
                    icon: Icons.merge_type_rounded,
                    label: "Open Source PRs",
                    value: "10+",
                    accentColor: const Color(0xFF64B5F6),
                    onTap: () => openExternalUrl(AppStrings.githubUrl),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatBox extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;
  final VoidCallback? onTap;

  const _StatBox({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
    this.onTap,
  });

  @override
  State<_StatBox> createState() => _StatBoxState();
}

class _StatBoxState extends State<_StatBox> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(true, label: "GITHUB");
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(false);
        }
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.surfaceElevated
                : AppColors.surfaceElevated.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? widget.accentColor.withValues(alpha: 0.45)
                  : AppColors.glassBorder,
              width: 1.2,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: widget.accentColor.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? widget.accentColor.withValues(alpha: 0.2)
                      : widget.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.accentColor.withValues(
                      alpha: _isHovered ? 0.35 : 0.15,
                    ),
                    width: 1,
                  ),
                ),
                child: Icon(widget.icon, color: widget.accentColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.value,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: AppColors.grey.withValues(alpha: 0.88),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GithubLinkButton extends StatefulWidget {
  const _GithubLinkButton();

  @override
  State<_GithubLinkButton> createState() => _GithubLinkButtonState();
}

class _GithubLinkButtonState extends State<_GithubLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(true, label: "GITHUB");
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        if (Get.isRegistered<AppCursorController>()) {
          AppCursorController.to.setHovered(false);
        }
      },
      child: GestureDetector(
        onTap: () => openExternalUrl(AppStrings.githubUrl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceElevated : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered
                  ? AppColors.orange.withValues(alpha: 0.45)
                  : AppColors.glassBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "GitHub",
                style: TextStyle(
                  color: _isHovered
                      ? AppColors.orange
                      : AppColors.white.withValues(alpha: 0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 6),
              AnimatedSlide(
                offset: _isHovered ? const Offset(0.15, -0.15) : Offset.zero,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 15,
                  color: _isHovered ? AppColors.orange : AppColors.grey,
                ),
              ),
            ],
          ),
        ),
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
        scale: _isHovered ? 1.012 : 1.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppColors.orange.withValues(alpha: 0.4)
                  : AppColors.divider,
              width: 1.2,
            ),
            color: AppColors.surface,
            boxShadow: [
              if (_isHovered) ...[
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 36,
                  spreadRadius: 2,
                  offset: const Offset(0, 16),
                ),
                BoxShadow(
                  color: AppColors.orange.withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ] else
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
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
