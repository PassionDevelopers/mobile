import 'package:flutter/material.dart';
import 'responsive_utils.dart';
import 'responsive_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget child;

  const ResponsiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return mobile ?? child;
    } else if (ResponsiveUtils.isTablet(context)) {
      return tablet ?? desktop ?? child;
    } else {
      return desktop ?? child;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, DeviceType deviceType) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    return builder(context, deviceType);
  }
}