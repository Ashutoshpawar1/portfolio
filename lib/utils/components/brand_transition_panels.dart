import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrandTransitionPanels extends StatelessWidget {
  final Animation<double> animation;
  final String label;

  const BrandTransitionPanels({
    super.key,
    required this.animation,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _TransitionPanel(
          animation: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.00, 0.50),
          ),
          color: const Color(0xFFFF4D2D),
          label: label,
        ),
        _TransitionPanel(
          animation: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.10, 0.62),
          ),
          color: const Color(0xFFFF5536),
          label: label,
        ),
        _TransitionPanel(
          animation: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.18, 0.72),
          ),
          color: const Color(0xFFFF5C3D),
          label: label,
        ),
        _TransitionPanel(
          animation: CurvedAnimation(
            parent: animation,
            curve: const Interval(0.26, 0.82),
          ),
          color: const Color(0xFFFF6242),
          label: label,
        ),
      ],
    );
  }
}

class BrandTransitionOverlay extends StatefulWidget {
  final String label;
  final VoidCallback? onReveal;
  final VoidCallback? onComplete;
  final Duration duration;

  const BrandTransitionOverlay({
    super.key,
    required this.label,
    this.onReveal,
    this.onComplete,
    this.duration = const Duration(milliseconds: 2200),
  });

  @override
  State<BrandTransitionOverlay> createState() => _BrandTransitionOverlayState();
}

class _BrandTransitionOverlayState extends State<BrandTransitionOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleProgress);
    _controller.addStatusListener(_handleStatus);
    _controller.forward();
  }

  void _handleProgress() {
    if (!_revealed && _controller.value >= 0.52) {
      _revealed = true;
      widget.onReveal?.call();
    }
  }

  void _handleStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onComplete?.call();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleProgress);
    _controller.removeStatusListener(_handleStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AbsorbPointer(
        child: BrandTransitionPanels(
          animation: _controller,
          label: widget.label,
        ),
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
        child: label.isEmpty
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 44,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final bool compact = constraints.maxWidth < 900;

                    if (compact) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Colors.black.withValues(alpha: 0.92),
                                  fontSize: 110,
                                  height: 0.9,
                                ),
                          ),
                          const SizedBox(height: 26),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Beyond\nVisuals.\nBuilt with\nVision.",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Colors.black.withValues(alpha: 0.9),
                                    fontSize: 42,
                                  ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 280.ms);
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            label,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  color: Colors.black.withValues(alpha: 0.92),
                                  fontSize: 190,
                                  height: 0.84,
                                ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Beyond\nVisuals.\nBuilt with\nVision.",
                              textAlign: TextAlign.right,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    color: Colors.black.withValues(alpha: 0.9),
                                    fontSize: 54,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(duration: 280.ms);
                  },
                ),
              ),
      ),
    );
  }
}
