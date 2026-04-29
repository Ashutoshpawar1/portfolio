import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet = const SizedBox(),
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return desktop;
        }
        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return tablet != const SizedBox() ? tablet : mobile;
        }
        return mobile;
      },
    );
  }
}
