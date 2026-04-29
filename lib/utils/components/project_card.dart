import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
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
          final cardWidth = 350.0;
          final cardHeight = 450.0;
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
              margin: const EdgeInsets.only(right: 30, bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  if (_isHovered)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 35,
                      offset: const Offset(0, 18),
                    ),
                ],
              ),
              child: GlassContainer(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [_buildImage(), _buildContent(context)],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Stack(
        children: [
          Image.network(
            widget.project.imageUrl,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
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

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.project.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.project.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey,
              height: 1.5,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.tech.map(_buildTechBadge).toList(),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              _buildActionButton(Icons.link, "View Demo"),
              const SizedBox(width: 20),
              _buildActionButton(Icons.code, "Source"),
            ],
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

  Widget _buildActionButton(IconData icon, String label) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.grey),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
