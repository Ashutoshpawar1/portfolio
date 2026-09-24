import 'package:flutter/material.dart';
import 'custom_cursor_overlay.dart';

/// Legacy export pointing to the redesigned fluid [CustomCursorOverlay].
class CustomCursor extends StatelessWidget {
  const CustomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomCursorOverlay();
  }
}
