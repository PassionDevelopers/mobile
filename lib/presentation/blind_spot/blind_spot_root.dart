import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/presentation/issue_list/issue_list_loading_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../../core/di/di_setup.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_root.dart';
import '../issue_list/main/issue_list_view.dart';
import '../issue_list/main/issue_list_view_model.dart';

class BlindSpotRoot extends StatelessWidget {
  const BlindSpotRoot({super.key, required this.onIssueSelected});
  final void Function(String issueId) onIssueSelected;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Column(
      children: [
        RegAppBar(title: '성향별 사각지대 이슈 보기'
          , iconData: Icons.visibility_off,
        ),
        Material(
          color: AppColors.background,
          child: TabBar(
            tabs: [
              Tab(text: '진보 사각지대'),
              Tab(text: '보수 사각지대'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Expanded(child: TabBarView(children: [
          SingleChildScrollView(
            child: IssueListRoot(
              issueType: IssueType.blindSpotLeft,
            ),
          ),
          SingleChildScrollView(
            child: IssueListRoot(
              issueType: IssueType.blindSpotRight,
            ),
          ),
        ]))
      ],
    ));
  }
}
