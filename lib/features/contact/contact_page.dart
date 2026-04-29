import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
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
    final Animation<Offset> contentOffset = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
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
                child: ContactContent(
                  onClose: () => context.pop(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Stack(
                    children: [
                      _TransitionPanel(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.00, 0.50),
                        ),
                        color: const Color(0xFFFF4D2D),
                        label: "",
                      ),
                      _TransitionPanel(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.10, 0.62),
                        ),
                        color: const Color(0xFFFF5536),
                        label: "",
                      ),
                      _TransitionPanel(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.18, 0.72),
                        ),
                        color: const Color(0xFFFF5C3D),
                        label: AppStrings.logoText,
                      ),
                      _TransitionPanel(
                        animation: CurvedAnimation(
                          parent: _controller,
                          curve: const Interval(0.26, 0.82),
                        ),
                        color: const Color(0xFFFF6242),
                        label: "",
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransitionPanel extends StatelessWidget {
  final Animation<double> animation;
  final Color color;
  final String label;

  const _TransitionPanel({
    required this.animation,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<Offset> slide = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1.1),
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOutCubic));

    return SlideTransition(
      position: slide,
      child: Container(
        color: color,
        child: Center(
          child: label.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  label,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.black.withOpacity(0.88),
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                  ),
                ).animate().fadeIn(duration: 350.ms),
        ),
      ),
    );
  }
}
