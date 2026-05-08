import 'dart:async';
import 'package:flutter/material.dart';
import '../../../constants/app_strings.dart';
import '../../../utils/components/animated_section_title.dart';
import '../../../utils/components/project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  double _scrollSpeed = 60.0; // Pixels per second
  bool _isReversed = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 5000);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(_handleScroll);
    _animationController.repeat();
  }

  void _handleScroll() {
    if (_scrollController.hasClients) {
      final double delta = _scrollSpeed / 60.0; // Approximate for 60fps
      final currentScroll = _scrollController.offset;

      if (_isReversed) {
        if (currentScroll <= 0) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
        } else {
          _scrollController.jumpTo(currentScroll - delta);
        }
      } else {
        if (currentScroll >= _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent / 2);
        } else {
          _scrollController.jumpTo(currentScroll + delta);
        }
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      child: Column(
        children: [
          const AnimatedSectionTitle(title: AppStrings.projectsTitle),
          const SizedBox(height: 70),
          SizedBox(
            height: 520,
            child: MouseRegion(
              onEnter: (_) => setState(() => _scrollSpeed = 20.0),
              onExit: (_) => setState(() => _scrollSpeed = 60.0),
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                // Large number to simulate infinity
                itemCount: 10000,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // Loop through projects
                  final project = appProjects[index % appProjects.length];
                  return ProjectCard(project: project);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
