import 'package:could_be/core/components/bias/bias_check_button.dart';
import 'package:could_be/core/components/buttons/back_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/presentation/issue_detail_feed/components/move_to_next_button.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_enum.dart';
import '../../../core/components/chips/key_word_chip_component.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/method/text_parsing.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/issue_detail.dart';
import '../../../ui/color.dart';
import '../../../ui/fonts.dart';

class IssueDetailTabs extends StatefulWidget {
  const IssueDetailTabs({super.key,
    required this.fontSize,
    required this.issue,
    required this.moveToNextPage});

  final IssueDetail issue;
  final VoidCallback moveToNextPage;
  final double fontSize;

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
    required String? text,
    required List<String>? keywords,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.large),
      child: TextCard(
        color: getBiasColor(bias),
        child: text == null? Center(child: NotFound(notFoundType: NotFoundType.article,)) :
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(keywords != null) SizedBox(
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
              Column(
                children: [
                  for(String para in parseAiText(text))
                    ...[
                    Text(
                      '• $para',
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        color: AppColors.gray1,
                      ),
                    ),
                  ]
                ],
              ),
              SizedBox(height: MyPaddings.medium),
            ],
          ),
        ),
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
        Row(children: [
          BackButton(),
          Column(
            children: [
              SizedBox(height: MyPaddings.medium),
              // MyText.h1('언론 성향별 요약'),
              MyText.h1('언론 성향별 차이점'),
              SizedBox(height: MyPaddings.medium),
            ],
          )
        ],),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: MyPaddings.large),
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
                      text: issue.leftSummary,
                      keywords: issue.leftKeywords,
                    ),
                    _buildTabViewPage(
                      bias: Bias.center,
                      text: issue.centerSummary,
                      keywords: issue.centerKeywords,
                    ),
                    _buildTabViewPage(
                      bias: Bias.right,
                      text: issue.rightSummary,
                      keywords: issue.rightKeywords,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MyPaddings.large),
                child: MoveToNextButton(moveToNextPage: widget.moveToNextPage, buttonText: '성향별 차이점 보기'),
              )
            ],
          ),
        )
      ],
    );
  }
}
