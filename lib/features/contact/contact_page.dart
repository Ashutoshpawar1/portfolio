import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../utils/components/brand_transition_panels.dart';
import 'widgets/contact_content.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> contentOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.52, 1, curve: Curves.easeOut),
    );
    final Animation<Offset> contentOffset =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.56, 1, curve: Curves.easeOutCubic),
          ),
        );

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF090909), Color(0xFF030303)],
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: contentOpacity,
            child: SlideTransition(
              position: contentOffset,
              child: SafeArea(
                child: ContactContent(onClose: () => context.pop()),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: BrandTransitionPanels(
                animation: _controller,
                label: AppStrings.logoText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
