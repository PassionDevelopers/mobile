import 'package:flutter/material.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_constants.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;
  final EdgeInsets? mobilePadding;
  final EdgeInsets? tabletPadding;
  final EdgeInsets? desktopPadding;
  final EdgeInsets? mobileMargin;
  final EdgeInsets? tabletMargin;
  final EdgeInsets? desktopMargin;
  final BoxDecoration? decoration;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileMargin,
    this.tabletMargin,
    this.desktopMargin,
    this.decoration,
    this.centerContent = false,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveUtils.getDeviceType(context);
    
    double? width;
    double? height;
    EdgeInsets? padding;
    EdgeInsets? margin;

    switch (deviceType) {
      case DeviceType.mobile:
        width = mobileWidth;
        height = mobileHeight;
        padding = mobilePadding;
        margin = mobileMargin;
        break;
      case DeviceType.tablet:
        width = tabletWidth ?? desktopWidth;
        height = tabletHeight ?? desktopHeight;
        padding = tabletPadding ?? desktopPadding;
        margin = tabletMargin ?? desktopMargin;
        break;
      case DeviceType.desktop:
        width = desktopWidth;
        height = desktopHeight;
        padding = desktopPadding;
        margin = desktopMargin;
        break;
    }

    Widget content = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );

    if (centerContent && ResponsiveUtils.isDesktop(context)) {
      return Center(child: content);
    }

    return content;
  }
}

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final double? elevation;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BorderRadius? borderRadius;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.elevation,
    this.color,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final responsivePadding = padding ?? ResponsiveUtils.getResponsivePadding(
      context,
      mobile: 12.0,
      tablet: 16.0,
      desktop: 20.0,
    );

    final responsiveMargin = margin ?? ResponsiveUtils.getResponsiveMargin(
      context,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );

    return Card(
      elevation: elevation ?? 2.0,
      color: color,
      margin: responsiveMargin,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Padding(
        padding: responsivePadding,
        child: child,
      ),
    );
  }
}

class ResponsiveConstrainedBox extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final double? maxHeight;
  final double? minWidth;
  final double? minHeight;
  final bool center;

  const ResponsiveConstrainedBox({
    super.key,
    required this.child,
    this.maxWidth,
    this.maxHeight,
    this.minWidth,
    this.minHeight,
    this.center = true,
  });

  @override
  Widget build(BuildContext context) {
    final actualMaxWidth = maxWidth ?? ResponsiveUtils.getMaxContentWidth(context);

    Widget constrainedChild = ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: actualMaxWidth,
        maxHeight: maxHeight ?? double.infinity,
        minWidth: minWidth ?? 0.0,
        minHeight: minHeight ?? 0.0,
      ),
      child: child,
    );

    if (center && ResponsiveUtils.isDesktop(context)) {
      return Center(child: constrainedChild);
    }

    return constrainedChild;
  }
}

class ResponsiveSizedBox extends StatelessWidget {
  final Widget? child;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? mobileHeight;
  final double? tabletHeight;
  final double? desktopHeight;

  const ResponsiveSizedBox({
    super.key,
    this.child,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.mobileHeight,
    this.tabletHeight,
    this.desktopHeight,
  });

  @override
  Widget build(BuildContext context) {
    double? width;
    double? height;

    if (ResponsiveUtils.isMobile(context)) {
      width = mobileWidth;
      height = mobileHeight;
    } else if (ResponsiveUtils.isTablet(context)) {
      width = tabletWidth ?? desktopWidth;
      height = tabletHeight ?? desktopHeight;
    } else {
      width = desktopWidth;
      height = desktopHeight;
    }

    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}