import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import '../issue_list/issue_type.dart';
import '../issue_list/main/issue_list_root.dart';

class BlindSpotRoot extends StatelessWidget {
  const BlindSpotRoot({super.key, required this.onIssueSelected});
  final void Function(String issueId) onIssueSelected;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          RegAppBar(
            title: '성향별 사각지대 이슈 보기',
            iconData: Icons.visibility_off,
          ),
          Material(
            color: AppColors.primaryLight,
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
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: IssueListRoot(
                      issueType: IssueType.blindSpotLeft,
                    ),
                ),
                Center(
                  child: IssueListRoot(
                      issueType: IssueType.blindSpotRight,
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
