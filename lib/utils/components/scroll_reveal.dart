import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;
  final Curve curve;
  final double visibleFraction;

  const ScrollReveal({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 0.08),
    this.duration = const Duration(milliseconds: 850),
    this.curve = Curves.easeOutExpo,
    this.visibleFraction = 0.08,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  late final Key _visibilityKey = ValueKey(
    'scroll-reveal-${identityHashCode(this)}',
  );
  bool _isVisible = false;

  void _handleVisibilityChanged(VisibilityInfo info) {
    if (_isVisible || !mounted) {
      return;
    }

    if (info.visibleFraction >= widget.visibleFraction) {
      setState(() => _isVisible = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: _handleVisibilityChanged,
      child: AnimatedOpacity(
        duration: widget.duration,
        curve: widget.curve,
        opacity: _isVisible ? 1 : 0,
        child: AnimatedSlide(
          duration: widget.duration,
          curve: widget.curve,
          offset: _isVisible ? Offset.zero : widget.beginOffset,
          child: widget.child,
        ),
      ),
    );
  }
}
