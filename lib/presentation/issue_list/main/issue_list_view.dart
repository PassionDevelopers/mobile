import 'package:could_be/core/components/layouts/bottom_safe_padding.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:flutter/material.dart';
import '../../../core/components/cards/issue_card.dart';
import '../../../domain/entities/issue/issue.dart';
import '../../../core/components/layouts/responsive_grid.dart';
import '../../../core/responsive/responsive_utils.dart';

class IssueListView extends StatelessWidget {
  const IssueListView({super.key, required this.issueList,
    required this.onBiasSelected, required this.isEvaluating,
    this.isEvaluatedView = false,
  });

  final List<Issue> issueList;
  final void Function({required Bias bias, required int index})? onBiasSelected;
  final bool? isEvaluating;
  final bool isEvaluatedView;

  @override
  Widget build(BuildContext context) {
    // 모바일에서는 기존처럼 Column 사용, 태블릿/데스크탑에서는 그리드 사용
    if (ResponsiveUtils.isMobile(context)) {
      return Column(
        children: [
          for (int i = 0; i < issueList.length; i++)
            IssueCard(
              issue: issueList[i], 
              isDailyIssue: false,
              isEvaluatedView: isEvaluatedView,
              onBiasSelected: (Bias bias) {
                if (onBiasSelected != null) {
                  onBiasSelected!(bias: bias, index: i);
                }
              }, 
              isEvaluating: isEvaluating,
            ),
          // 모바일에서는 하단 안전 패딩 추가
          BottomSafePadding()
        ],
      );
    }

    // 태블릿/데스크탑에서는 반응형 그리드 사용
    return ResponsiveGrid(
      children: issueList.asMap().entries.map((entry) {
        int i = entry.key;
        Issue issue = entry.value;
        return IssueCard(
          issue: issue,
          isDailyIssue: false,
          isEvaluatedView: isEvaluatedView,
          onBiasSelected: (Bias bias) {
            if (onBiasSelected != null) {
              onBiasSelected!(bias: bias, index: i);
            }
          },
          isEvaluating: isEvaluating,
        );
      }).toList(),
    );
  }
}
