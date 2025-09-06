import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class MyPopupMenu extends StatelessWidget {
  const MyPopupMenu({super.key, required this.isMine, required this.onReportPressed, required this.onDeletePressed});

  final bool isMine; // Example property, replace with actual logic
  final VoidCallback? onReportPressed; // Example callback, replace with actual logic
  final VoidCallback? onDeletePressed; // Example callback, replace with actual logic

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: AppColors.primaryLight,
      onSelected: (value) {
        switch (value) {
          case 'report':
            onReportPressed?.call();
            break;
          case 'delete':
            onDeletePressed?.call();
            break;
        }
      },
      itemBuilder: (context) {
        List<PopupMenuEntry<String>> items = [
          PopupMenuItem<String>(
            value: 'report',
            child: SizedBox(
              width: 100,
              child: Row(
                children: [
                  Icon(Icons.report_outlined, size: 16, color: AppColors.gray2),
                  SizedBox(width: 8),
                  MyText.reg('신고', color: AppColors.textPrimary),
                ],
              ),
            ),
          ),
        ];

        if (isMine) {
          items.add(
            PopupMenuItem<String>(
              value: 'delete',
              child: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 16, color: AppColors.warning),
                    SizedBox(width: 8),
                    MyText.reg('삭제', color: AppColors.warning),
                  ],
                ),
              ),
            ),
          );
        }
        return items;
      },
      icon: Icon(Icons.more_vert, color: AppColors.gray2, size: 16),
      padding: EdgeInsets.zero,
    );
  }
}
