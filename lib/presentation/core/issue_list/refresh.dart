
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';

class IssueListRefresher extends StatelessWidget {
  const IssueListRefresher({super.key, required this.onRefresh, required this.content});
  final Future<void> Function() onRefresh;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: AppColors.primaryLight,
      color: AppColors.primary,
      child: content
    );
  }
}
