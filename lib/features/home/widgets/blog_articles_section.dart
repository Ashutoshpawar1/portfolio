import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../utils/components/animated_section_title.dart';

class BlogArticlesSection extends StatelessWidget {
  const BlogArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: width < 720 ? 18 : 40,
      ),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: "Blog & Articles"),
          const SizedBox(height: 32),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Sharing insights, tutorials, and deep dives into Flutter, Dart, and Software Architecture.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.grey.withOpacity(0.92),
                fontSize: width < 720 ? 16 : 18,
                height: 1.7,
              ),
            ),
          ),
          const SizedBox(height: 64),
          _HoverCard(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
              child: Column(
                children: [
                  Icon(Icons.edit_note_rounded, size: 64, color: AppColors.grey.withOpacity(0.5)),
                  const SizedBox(height: 24),
                  Text(
                    "Exciting content is on the way.\nStay tuned!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
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

  const _HoverCard({required this.child});

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppColors.orange.withOpacity(0.4) : AppColors.divider,
            ),
            color: AppColors.surface.withOpacity(0.5),
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
          child: widget.child,
        ),
      ),
    );
  }
}
