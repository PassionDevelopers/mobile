import 'package:flutter/material.dart';

import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/components/navigation/custom_bottom_navigation_bar.dart';
import '../../../ui/color.dart';
import '../../core/themes/margins_paddings.dart';

class HomeView extends StatelessWidget {
  final Widget body;
  final int currentPageIndex;
  final void Function(int index) setCurrentIndex;

  HomeView({
    super.key,
    required this.body,
    required this.currentPageIndex,
    required this.setCurrentIndex,
  });

  final List<String?> appBarTitles = [null, '토픽', '사각지대', '매체 성향', '마이페이지'];

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar:
          currentPageIndex == 0
              ? AppBar(
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
                actions: [
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
              : null,
      appBarTitle: appBarTitles[currentPageIndex],
      body: Ink(color: AppColors.background, child: body),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: setCurrentIndex,
      ),
    );
  }
}
