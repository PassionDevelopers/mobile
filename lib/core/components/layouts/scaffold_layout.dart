import 'package:could_be/core/components/navigation/custom_bottom_navigation_bar.dart';
import 'package:could_be/core/responsive/responsive_constants.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';
import '../../responsive/responsive_layout.dart';
import '../navigation/side_navigation_bar.dart';

class RegScaffold extends StatelessWidget {
  const RegScaffold({
    super.key,
    required this.isScrollPage,
    required this.body,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.showBottomBar = true,
    this.appBarTitle,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,

    this.sideNavigationBar,
  });

  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool showBottomBar;
  final bool isScrollPage;
  final String? appBarTitle;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? sideNavigationBar;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return _buildMobileLayout(context);
          case DeviceType.tablet:

          case DeviceType.desktop:
            return _buildDesktopLayout(context);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final safeBottomPadding = MediaQuery.of(context).padding.bottom;
    return Container(
      color: AppColors.primaryLight,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar ?? (appBarTitle != null
              ? AppBar(
            title: MyText.h2(appBarTitle!),
            backgroundColor: AppColors.primaryLight,
          )
              : null),
          drawer: drawer,
          endDrawer: endDrawer,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          body: Column(
            children: [
              Expanded(child: body),
              if(!isScrollPage) Container(height: safeBottomPadding,  color: AppColors.primaryLight,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? (appBarTitle != null
          ? AppBar(
        title: MyText.h2(appBarTitle!),
        backgroundColor: AppColors.primaryLight,
      )
          : null),
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: false,
      body: body,
      // 데스크탑에서는 하단 네비게이션 숨김
      bottomNavigationBar: null,
    );
  }

}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.body,
    this.drawer,
    this.endDrawer,
    this.showBottomBar = true,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.sideNavigationBar,
    required this.currentNavigationIndex,
    required this.onNavigationChanged,
  });

  final Widget body;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool showBottomBar;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? sideNavigationBar;
  final int currentNavigationIndex;
  final Function(int) onNavigationChanged;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        switch (deviceType) {
          case DeviceType.mobile:
            return _buildMobileLayout(context);
          case DeviceType.tablet:
          case DeviceType.desktop:
            return _buildDesktopLayout(context);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.primaryLight,
      child: SafeArea(
        child: Scaffold(
          drawer: drawer,
          endDrawer: endDrawer,
          resizeToAvoidBottomInset: true,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          // body: body,
          body: body,
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: currentNavigationIndex,
            onTap: onNavigationChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: false,
      body: Row(
        children: [
          // 사이드 네비게이션
          if (sideNavigationBar != null)
            sideNavigationBar!
          else
            SideNavigationBar(
              currentIndex: currentNavigationIndex,
              onTap: onNavigationChanged,
            ),
          // 메인 컨텐츠
          Expanded(
            child: body,
          ),
        ],
      ),
      // 데스크탑에서는 하단 네비게이션 숨김
      bottomNavigationBar: null,
    );
  }
}
