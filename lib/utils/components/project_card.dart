import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';
import 'glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'project_details_dialog.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isCompactCard = screenWidth < 520;
    final double cardWidth = screenWidth < 440
        ? screenWidth - 40
        : (screenWidth < 720
              ? (screenWidth * 0.8 - 20).clamp(320.0, 360.0)
              : (screenWidth < 1200
                    ? (screenWidth * 0.45 - 40).clamp(340.0, 420.0)
                    : (screenWidth * 0.32 - 40).clamp(360.0, 480.0)));
    final double cardHeight = screenWidth < 440 ? 620.0 : 580.0;
    final double imageHeight = screenWidth < 440
        ? 180.0
        : (screenWidth < 900 ? 200.0 : 220.0);

    return GestureDetector(
      onTap: () {
        ProjectDetailsDialog.show(context, widget.project, appProjects);
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child:
            Container(
                  width: cardWidth,
                  height: cardHeight,
                  margin: EdgeInsets.only(
                    right: screenWidth < 720 ? 12 : 30,
                    bottom: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      if (_isHovered)
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          blurRadius: 44,
                          offset: const Offset(0, 24),
                        ),
                    ],
                  ),
                  child: GlassContainer(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(imageHeight),
                        Expanded(
                          child: _buildContent(
                            context,
                            isCompactCard: isCompactCard,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .animate(target: _isHovered ? 1.0 : 0.0)
                .scale(
                  begin: const Offset(1.0, 1.0),
                  end: const Offset(1.015, 1.015),
                  duration: 250.ms,
                  curve: Curves.easeOutCubic,
                )
                .slideY(
                  begin: 0.0,
                  end: -0.012,
                  duration: 250.ms,
                  curve: Curves.easeOutCubic,
                ),
      ),
    );
  }

  Widget _buildImage(double imageHeight) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          CachedNetworkImage(
                imageUrl: widget.project.imageUrl.isNotEmpty
                    ? widget.project.imageUrl
                    : "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 180),
                fadeOutDuration: const Duration(milliseconds: 100),
                errorWidget: (context, url, error) {
                  return Container(
                    height: imageHeight,
                    width: double.infinity,
                    color: AppColors.surfaceElevated,
                    child: Center(
                      child: Icon(
                        Icons.code_rounded,
                        color: AppColors.grey,
                        size: 50,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return Container(
                    height: imageHeight,
                    width: double.infinity,
                    color: AppColors.surfaceElevated,
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white.withValues(alpha: 0.2),
                        ),
                      ),
                    ),
                  );
                },
              )
              .animate(target: _isHovered ? 1.0 : 0.0)
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.06, 1.06),
                duration: 600.ms,
                curve: Curves.easeOutCubic,
              ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.44),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child:
                  Container(
                        color: Colors.black.withValues(alpha: 0.32),
                        child: Center(
                          child: const Icon(
                            Icons.open_in_new,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                      .animate(target: _isHovered ? 1.0 : 0.0)
                      .fadeIn(duration: 220.ms, curve: Curves.easeOutCubic)
                      .scale(
                        begin: const Offset(0.85, 0.85),
                        end: const Offset(1.0, 1.0),
                        duration: 220.ms,
                        curve: Curves.easeOutCubic,
                      ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isCompactCard}) {
    final List<Widget> actionButtons = [
      if (widget.project.playStoreUrl.isNotEmpty)
        _buildActionButton(
          Icons.android_rounded,
          "Google Play",
          widget.project.playStoreUrl,
        ),
      if (widget.project.appStoreUrl.isNotEmpty)
        _buildActionButton(
          Icons.apple_rounded,
          "App Store",
          widget.project.appStoreUrl,
        ),
      if (widget.project.playStoreUrl.isEmpty &&
          widget.project.appStoreUrl.isEmpty) ...[
        _buildActionButton(Icons.lock_outline_rounded, "Private Project"),
        _buildActionButton(Icons.article_outlined, "Case Study"),
      ],
    ];
    final int maxTechBadges = isCompactCard ? 3 : 4;
    final List<String> visibleTech = widget.project.tech
        .take(maxTechBadges)
        .toList(growable: false);

    return Padding(
      padding: EdgeInsets.all(isCompactCard ? 18 : 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.project.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: isCompactCard ? 19 : 21,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Flexible(
            child: Text(
              widget.project.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grey,
                height: 1.5,
              ),
              maxLines: isCompactCard ? 3 : 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: isCompactCard ? 12 : 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: visibleTech.map(_buildTechBadge).toList(),
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 12, runSpacing: 12, children: actionButtons)
              .animate(target: _isHovered ? 1.0 : 0.0)
              .fadeIn(duration: 250.ms, curve: Curves.easeOutCubic)
              .slideY(
                begin: 0.12,
                end: 0.0,
                duration: 250.ms,
                curve: Curves.easeOutCubic,
              ),
        ],
      ),
    );
  }

  Widget _buildTechBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, [String? url]) {
    final bool enabled = url != null && url.isNotEmpty;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: enabled ? () => openExternalUrl(url) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withValues(alpha: enabled ? 0.08 : 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: enabled
                  ? Colors.white.withValues(alpha: 0.18)
                  : AppColors.divider,
            ),
            boxShadow: [
              if (_isHovered && enabled)
                BoxShadow(
                  color: const Color(0x33FF7A36),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: enabled ? AppColors.white : AppColors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: enabled ? AppColors.white : AppColors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
