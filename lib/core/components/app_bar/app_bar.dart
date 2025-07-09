import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_utils.dart';
import '../../responsive/responsive_layout.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;
    
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: toolbarHeight,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: isDesktop ? MyPaddings.large.toDouble() : MyPaddings.mediumLarge.toDouble(),
              horizontal: isDesktop ? MyPaddings.large.toDouble() : 0,
            ),
            child: Image.asset(
              'assets/images/logo/logo_black.jpeg',
              height: isDesktop ? 50 : 40,
            ),
          ),
        ),
      ),
    );
  }
}

class RegAppBar extends StatelessWidget {
  const RegAppBar({super.key, this.iconData, required this.title, });
  final IconData? iconData;
  final String title;
  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    final toolbarHeight = isDesktop ? 80.0 : AppBar().preferredSize.height;
    
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: !isDesktop, // 데스크탑에서는 back button 숨김
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: toolbarHeight,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: toolbarHeight,
        child: Row(
          children: [
            Icon(
              iconData,
              size: isDesktop ? 28 : 24,
            ),
            SizedBox(width: isDesktop ? MyPaddings.extraLarge.toDouble() : MyPaddings.large.toDouble()),
            Expanded(
              child: MyText.h2(
                title,
                fontSize: isDesktop ? 20 : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

