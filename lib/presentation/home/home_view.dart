import 'package:flutter/material.dart';

import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../core/components/navigation/custom_bottom_navigation_bar.dart';
import '../../../ui/color.dart';

class HomeView extends StatelessWidget {
  final Widget body;
  final int currentPageIndex;
  final void Function(int index) setCurrentIndex;

  const HomeView({
    super.key,
    required this.body,
    required this.currentPageIndex,
    required this.setCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Ink(color: AppColors.background, child: body),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: setCurrentIndex,
      ),
    );
  }
}
