import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({
    super.key,
    required this.body,
    this.bottomNavigationBar,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.showBottomBar = true,
    this.appBarTitle,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool showBottomBar;
  final String? appBarTitle;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.background,
      child: SafeArea(
        child: Scaffold(
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
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}
