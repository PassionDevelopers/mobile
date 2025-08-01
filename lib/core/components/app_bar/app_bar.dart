import 'dart:developer';

import 'package:could_be/core/components/app_bar/search_field.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_layout.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key, required this.onSearchSubmitted});
  final void Function(String query) onSearchSubmitted;

  Widget _buildLogo() {
    final toolbarHeight = AppBar().preferredSize.height;

    return Ink(
      color: AppColors.primaryLight,
      height: toolbarHeight,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MyPaddings.mediumLarge.toDouble(),
          ),
          child: Image.asset('assets/images/logo/logo_black.jpeg', height: 40),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchAppBar(
      appBar: _buildLogo(),
      onSearchSubmitted: onSearchSubmitted,
      onNoticePressed: (){
        context.push(RouteNames.notice);
      },
    );
  }
}

class RegAppBar extends StatelessWidget {
  const RegAppBar({
    super.key,
    this.iconData,
    required this.title,
    this.actions,
  });

  final IconData? iconData;
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;

    return AppBar(
      centerTitle: true,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: !isDesktop,
      // 데스크탑에서는 back button 숨김
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: toolbarHeight,
        child: Row(
          children: [
            Icon(iconData, size: isDesktop ? 28 : 24),
            SizedBox(
              width:
                  isDesktop
                      ? MyPaddings.extraLarge.toDouble()
                      : MyPaddings.large.toDouble(),
            ),
            Expanded(child: MyText.h2(title, fontSize: isDesktop ? 20 : null)),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
