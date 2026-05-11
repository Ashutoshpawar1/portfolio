import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;
  final Curve curve;
  final double triggerOffset;

  const ScrollReveal({
    super.key,
    required this.child,
    this.beginOffset = const Offset(0, 0.08),
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOutCubic,
    this.triggerOffset = 0.88,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  final GlobalKey _contentKey = GlobalKey();
  late final ScrollController _scrollController;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController = Get.find<HomeController>().scrollController;
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleScroll());
  }

  void _handleScroll() {
    if (_isVisible || !mounted) {
      return;
    }

    final BuildContext? targetContext = _contentKey.currentContext;
    if (targetContext == null) {
      return;
    }

    final RenderObject? renderObject = targetContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final double viewportHeight = MediaQuery.of(context).size.height;
    final double top = renderObject.localToGlobal(Offset.zero).dy;

    if (top <= viewportHeight * widget.triggerOffset) {
      setState(() => _isVisible = true);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: widget.duration,
      curve: widget.curve,
      opacity: _isVisible ? 1 : 0,
      child: AnimatedSlide(
        duration: widget.duration,
        curve: widget.curve,
        offset: _isVisible ? Offset.zero : widget.beginOffset,
        child: KeyedSubtree(key: _contentKey, child: widget.child),
      ),
    );
  }
}
