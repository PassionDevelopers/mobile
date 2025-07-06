import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: AppBar().preferredSize.height,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: AppBar().preferredSize.height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: MyPaddings.mediumLarge,
            ),
            child: Image.asset('assets/images/logo/logo_black.jpeg'),
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
    return AppBar(
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: true,
      backgroundColor: AppColors.primaryLight,
      toolbarHeight: AppBar().preferredSize.height,
      elevation: 0,
      title: Ink(
        color: AppColors.primaryLight,
        height: AppBar().preferredSize.height,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(width: MyPaddings.large),
            MyText.h2(title,),
          ],
        )
      ),
    );
  }
}

