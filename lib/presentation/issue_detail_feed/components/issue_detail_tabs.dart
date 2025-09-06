
import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:flutter/material.dart';

import '../../../core/components/chips/key_word_chip_component.dart';
import '../../../core/method/bias/bias_enum.dart';
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
    required this.postDasiScore,
    required this.isSpread,
    required this.spreadCallback,
  });

  final IssueDetail issue;
  final double fontSize;
  final VoidCallback postDasiScore;
  final bool isSpread;
  final VoidCallback spreadCallback;

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

  bool isPosted = false;
  late List<bool> isWatchedBias;

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
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? _biasColors[index] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${_biasLabels[index]} 언론',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.gray2,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
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
    return text == null? bias == Bias.center?
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.keyboard_arrow_left_outlined, color: AppColors.gray2),
              onPressed: (){
                _tabController.animateTo(0);
              }
            ),
            NotFound(notFoundType: NotFoundType.article,),
            IconButton(
                icon: Icon(Icons.keyboard_arrow_right_outlined, color: AppColors.gray2),
                onPressed: (){
                  _tabController.animateTo(2);
                }
            ),
          ],
        ):
    Center(child: NotFound(notFoundType: NotFoundType.article,)) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(keywords != null && keywords.isNotEmpty) Column(
            children: [
              SizedBox(
                height: 32,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return KeyWordChip(
                      title: keywords[index],
                      textColor: AppColors.white,
                      color: getBiasColor(bias),
                      borderColor: getBiasColor(bias),
                    );
                  },
                  itemCount: keywords.length,
                  shrinkWrap: true,
                ),
              ),
              SizedBox(height: MyPaddings.large),
            ],
          ),
          parseAiText(text, widget.fontSize, AppColors.gray1, getBiasColor(bias)),
        ],
      );
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isWatchedBias = [
      issue.leftSummary == null,
      true,
      issue.rightSummary == null,
    ];
    _tabController.addListener(() {
      setState(() {
      });
      // 탭이 변경될 때마다 isWatchedBias 업데이트
      if(!isPosted) {
        isWatchedBias = [
          _tabController.index == 0 ? true : isWatchedBias[0],
          true,
          _tabController.index == 2 ? true : isWatchedBias[2],
        ];
        if(!isWatchedBias.contains(false)){
          widget.postDasiScore();
          isPosted = true;
        }
      }
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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.spreadCallback,
            child: Container(
              padding: EdgeInsets.all(MyPaddings.large),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.gray5,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.balance,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  SizedBox(width: MyPaddings.medium),
                  Text(
                    '성향별 관점 요약',
                    style: MyFontStyle.h2.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    widget.isSpread ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
          if(widget.isSpread)
            Padding(
              padding: EdgeInsets.all(MyPaddings.large),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
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
                  SizedBox(height: MyPaddings.large),
                  AutoSizedTabBarView(
                    tabController: _tabController,
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
                ],
              ),
            ),
        ],
      ),
    );
  }
}
