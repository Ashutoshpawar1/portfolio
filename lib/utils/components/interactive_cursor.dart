import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_cursor_controller.dart';

/// Wraps an interactive widget to notify [AppCursorController] on hover
/// while preventing OS hand cursors from leaking through.
class InteractiveCursor extends StatefulWidget {
  final Widget child;
  final CursorType cursorType;
  final String? label;
  final VoidCallback? onTap;
  final bool enableScale;
  final double hoverScale;

  const InteractiveCursor({
    super.key,
    required this.child,
    this.cursorType = CursorType.interactive,
    this.label,
    this.onTap,
    this.enableScale = false,
    this.hoverScale = 1.04,
  });

  @override
  State<InteractiveCursor> createState() => _InteractiveCursorState();
}

class _InteractiveCursorState extends State<InteractiveCursor> {
  bool _isHovered = false;

  void _onEnter(PointerEvent _) {
    if (!mounted) return;
    setState(() => _isHovered = true);
    if (Get.isRegistered<AppCursorController>()) {
      AppCursorController.to.setHovered(
        true,
        type: widget.cursorType,
        label: widget.label,
      );
    }
  }

  void _onExit(PointerEvent _) {
    if (!mounted) return;
    setState(() => _isHovered = false);
    if (Get.isRegistered<AppCursorController>()) {
      AppCursorController.to.setHovered(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (widget.enableScale) {
      content = AnimatedScale(
        scale: _isHovered ? widget.hoverScale : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        child: content,
      );
    }

    return MouseRegion(
      // Keep cursor as none so the OS pointer doesn't fight the custom cursor
      cursor: SystemMouseCursors.none,
      onEnter: _onEnter,
      onExit: _onExit,
      child: widget.onTap != null
          ? GestureDetector(
              onTap: widget.onTap,
              behavior: HitTestBehavior.opaque,
              child: content,
            )
          : content,
    );
  }
}
