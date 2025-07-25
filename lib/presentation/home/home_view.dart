import 'package:could_be/core/di/di_setup.dart';
import 'package:flutter/material.dart';
import '../../../core/components/layouts/scaffold_layout.dart';
import '../../../ui/color.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
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
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver{

  late final HomeViewModel viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = getIt<HomeViewModel>();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      viewModel.showNotice(context);
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      currentNavigationIndex: widget.currentPageIndex,
      onNavigationChanged: widget.setCurrentIndex,
      body: Ink(color: AppColors.background, child: widget.body),
    );
  }
}
