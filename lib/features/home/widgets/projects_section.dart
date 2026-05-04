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

class _ProjectsSectionState extends State<ProjectsSection> {
  late ScrollController _scrollController;
  Timer? _timer;
  double _scrollSpeed = 1.0;
  bool _isReversed = true; // Content moves left to right

  @override
  void initState() {
    super.initState();
    // Start at a large offset to allow left-to-right scrolling immediately
    _scrollController = ScrollController(initialScrollOffset: 5000);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (_scrollController.hasClients) {
        final currentScroll = _scrollController.offset;

        if (_isReversed) {
          // Moving Left to Right: Decrement offset
          if (currentScroll <= 0) {
            // Jump to a middle point of the infinite-like list
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent / 2,
            );
          } else {
            _scrollController.jumpTo(currentScroll - _scrollSpeed);
          }
        } else {
          // Moving Right to Left: Increment offset
          if (currentScroll >= _scrollController.position.maxScrollExtent) {
            _scrollController.jumpTo(
              _scrollController.position.maxScrollExtent / 2,
            );
          } else {
            _scrollController.jumpTo(currentScroll + _scrollSpeed);
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
              onEnter: (_) => setState(() => _scrollSpeed = 0.3),
              onExit: (_) => setState(() => _scrollSpeed = 1.0),
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
