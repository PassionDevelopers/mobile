import 'package:flutter/material.dart';

import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key, this.appBar, required this.body, this.bottomNavigationBar, this.appBarColor,
    this.drawer, this.endDrawer, this.showBottomBar = true, this.showAppBar = true, this.appBarTitle, this.backgroundColor, this.floatingActionButton,
    this.floatingActionButtonLocation});
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool showBottomBar;
  final bool showAppBar;
  final Color? appBarColor;
  final String? appBarTitle;
  final Color? backgroundColor;
  final FloatingActionButton? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.background,
      child: SafeArea(child: Scaffold(

          drawer: drawer,
          endDrawer: endDrawer,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButton: floatingActionButton,
          resizeToAvoidBottomInset: false,
          appBar: appBar ?? ( showAppBar ? AppBar(
            backgroundColor: appBarColor ?? AppColors.background,
            elevation: 0,
            centerTitle: false,
            title: Text(appBarTitle ?? '', style: MyFontStyle.h1),
            actions: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.grey[600]),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                onPressed: () {},
              ),
            ],
          ) : null ),
          body: body,
          bottomNavigationBar: bottomNavigationBar
      )),
    );
  }
}


