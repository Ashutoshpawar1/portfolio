import 'dart:ui';
import 'package:flutter/material.dart';

/// Global scroll configuration enabling authentic iOS-style bouncing physics
/// and fluid drag scrolling across touch, mouse, trackpad, and stylus devices.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    // Subtle custom scrollbar or defer to child for clean presentation
    return child;
  }
}
