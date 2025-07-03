import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_enum.dart';
import '../../../core/components/chips/key_word_chip_component.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class IssueDetailTabs extends StatefulWidget {
  const IssueDetailTabs({super.key, required this.issue});

  final IssueDetail issue;

  @override
  State<IssueDetailTabs> createState() => _IssueDetailTabsState();
}

class _IssueDetailTabsState extends State<IssueDetailTabs>
    with TickerProviderStateMixin {
  final List<Color> _biasColors = [
    AppColors.left,
    AppColors.center,
    AppColors.right,
    // const Color(0xFFE53E3E), // 진보 - 빨강
    // const Color(0xFF38A169), // 중도 - 초록
    // const Color(0xFF3182CE), // 보수 - 파랑
  ];

  final List<String> _biasLabels = ['진보', '중도', '보수'];

  late final IssueDetail issue = widget.issue;

  late final TabController _tabController = TabController(
    length: 3,
    initialIndex: 1,
    vsync: this,
  );

  _buildTab(int index) {
    final isSelected = index == _tabController.index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          _tabController.animateTo(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? _biasColors[index] : Colors.transparent,
            borderRadius: BorderRadius.circular(9),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: _biasColors[index].withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: Text(
            '${_biasLabels[index]} 언론',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  _buildTabViewPage({
    required Bias bias,
    required String text,
    required List<String> keywords,
  }) {
    return TextCard(
      color: getBiasColor(bias),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 26,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return KeyWordChip(
                    title: keywords[index],
                    color: Colors.transparent,
                    borderColor: getBiasColor(bias),
                  );
                },
                itemCount: keywords.length,
                shrinkWrap: true,
              ),
            ),
          ),
          SizedBox(height: MyPaddings.medium),
          MyText.article(text),
          SizedBox(height: MyPaddings.medium),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.h1('언론 성향별 요약'),
        SizedBox(height: MyPaddings.medium),
        Container(
          decoration: BoxDecoration(
            color: AppColors.gray5,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: List.generate(3, (index) {
              return _buildTab(index);
            }),
          ),
        ),
        SizedBox(height: MyPaddings.small),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTabViewPage(
                bias: Bias.left,
                text: issue.leftSummary ?? '진보 언론의 기사가 없습니다.',
                keywords: issue.leftKeywords ?? [],
              ),
              _buildTabViewPage(
                bias: Bias.center,
                text: issue.centerSummary ?? '중도 언론의 기사가 없습니다.',
                keywords: issue.centerKeywords ?? [],
              ),
              _buildTabViewPage(
                bias: Bias.right,
                text: issue.rightSummary ?? '보수 언론의 기사가 없습니다.',
                keywords: issue.rightKeywords ?? [],
              ),
            ],
          ),
        ),
        SizedBox(height: MyPaddings.medium),
      ],
    );
  }
}
