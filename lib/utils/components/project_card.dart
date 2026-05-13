import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../services/external_link_service.dart';
import 'glass_container.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;
  Offset _mousePos = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isCompactCard = screenWidth < 520;
    final double cardWidth = screenWidth < 440
        ? screenWidth - 40
        : (screenWidth < 720 ? 320.0 : 350.0);
    final double cardHeight = screenWidth < 440
        ? 490.0
        : (screenWidth < 900 ? 500.0 : 490.0);
    final double imageHeight = screenWidth < 440
        ? 180.0
        : (screenWidth < 900 ? 200.0 : 220.0);

    return MouseRegion(
      onEnter: (event) => setState(() {
        _isHovered = true;
        _mousePos = event.localPosition;
      }),
      onExit: (_) => setState(() => _isHovered = false),
      onHover: (event) => setState(() => _mousePos = event.localPosition),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 200),
        tween: Tween(begin: 0.0, end: _isHovered ? 1.0 : 0.0),
        builder: (context, value, child) {
          final centerX = cardWidth / 2;
          final centerY = cardHeight / 2;
          final dx = (_mousePos.dx - centerX) / centerX;
          final dy = (_mousePos.dy - centerY) / centerY;

          final matrix = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(dy * 0.12 * value)
            ..rotateY(-dx * 0.12 * value);

          return Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: Container(
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
                      color: Colors.black.withOpacity(0.4),
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(double imageHeight) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          AnimatedScale(
            scale: _isHovered ? 1.06 : 1,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            child: Image.network(
              widget.project.imageUrl.isNotEmpty
                  ? widget.project.imageUrl
                  : "https://images.unsplash.com/photo-1555066931-4365d14bab8c",
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: imageHeight,
                  width: double.infinity,
                  color: AppColors.surfaceElevated,
                  child: const Center(
                    child: Icon(
                      Icons.code_rounded,
                      color: AppColors.grey,
                      size: 50,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: imageHeight,
                  width: double.infinity,
                  color: AppColors.surfaceElevated,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                      color: AppColors.white.withOpacity(0.2),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.08),
                    Colors.black.withOpacity(0.44),
                  ],
                ),
              ),
            ),
          ),
          if (_isHovered)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.32),
                child: Center(
                  child: Icon(
                    Icons.open_in_new,
                    color: Colors.white,
                    size: 40,
                  ).animate().scale().fadeIn(),
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

    return Padding(
      padding: EdgeInsets.all(isCompactCard ? 20 : 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            widget.project.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: isCompactCard ? 20 : 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
            maxLines: isCompactCard ? 3 : 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: isCompactCard ? 16 : 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.tech.map(_buildTechBadge).toList(),
          ),
          const Spacer(),
          AnimatedSlide(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            offset: _isHovered ? Offset.zero : const Offset(0, 0.12),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 260),
              opacity: _isHovered ? 1 : 0.82,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: actionButtons,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        label,
        style: const TextStyle(
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
                ? Colors.white.withOpacity(enabled ? 0.08 : 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: enabled
                  ? Colors.white.withOpacity(0.18)
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
