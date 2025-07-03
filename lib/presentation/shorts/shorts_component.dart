import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../core/components/bias/bias_label.dart';
import '../../core/components/buttons/label_icon_button.dart';
import '../../core/components/chips/key_word_chip_component.dart';
import '../../core/method/bias/bias_method.dart';
import '../../core/themes/margins_paddings.dart';
import '../../domain/entities/issue_detail.dart';
import '../../ui/color.dart';
import '../../ui/fonts.dart';

class ShortsComponent extends StatefulWidget {
  const ShortsComponent({
    super.key,
    required this.issue,
    required this.manageIssueSubscription,
  });

  final IssueDetail issue;
  final VoidCallback manageIssueSubscription;

  @override
  State<ShortsComponent> createState() => _ShortsComponentState();
}

class _ShortsComponentState extends State<ShortsComponent>
    with TickerProviderStateMixin {
  Bias currentBias = Bias.center;
  late final IssueDetail issue = widget.issue;
  late final TabController _tabController = TabController(
    length: 3,
    initialIndex: 1,
    vsync: this,
  );

  final List<Color> _biasColors = [
    AppColors.left,
    AppColors.center,
    AppColors.right,
    // const Color(0xFFE53E3E), // 진보 - 빨강
    // const Color(0xFF38A169), // 중도 - 초록
    // const Color(0xFF3182CE), // 보수 - 파랑
  ];

  final List<String> _biasLabels = ['진보', '중도', '보수'];

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {
        currentBias =
            [Bias.left, Bias.center, Bias.right][_tabController.index];
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
    return Ink(
      color: AppColors.primaryLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          issue.imageUrl != null
              ? ImageContainer(height: 150, imageUrl: issue.imageUrl!)
              : SizedBox(),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: MyPaddings.medium,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: MyPaddings.small),
                    child: MyText.h1(issue.title, maxLines: 3),
                  ),
                  IssueInfoTitle(
                    mediaTotal: issue.coverageSpectrum.total,
                    viewCount: issue.view,
                    time: issue.updatedAt ?? issue.createdAt,
                  ),
                  SizedBox(height: MyPaddings.small),
                  Expanded(
                    child: Column(
                      children: [
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
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              ShortsInnerPage(
                                bias: Bias.left,
                                text: issue.leftSummary,
                                keywords: issue.leftKeywords,
                                issueId: issue.id,
                              ),
                              ShortsInnerPage(
                                bias: Bias.center,
                                text: issue.centerSummary,
                                keywords: issue.centerKeywords,
                                issueId: issue.id,
                              ),
                              ShortsInnerPage(
                                bias: Bias.right,
                                text: issue.rightSummary,
                                keywords: issue.rightKeywords,
                                issueId: issue.id,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Ink(
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LabelIconButton(
                  iconData: Icons.newspaper_outlined,
                  label: '원문 기사',
                  onTap: () {
                    context.push(
                      RouteNames.webView,
                      extra: {'issueInfo': (issue.id, Bias.center)},
                    );
                  },
                ),
                LabelIconButton(
                  iconData: Icons.balance_outlined,
                  label: '차이점 분석',
                  onTap: () {
                    context.push('/shortsPlayer/${issue.id}');
                  },
                ),
                // Flexible(
                //   child: LabelIconButton(
                //     iconData: Icons.comment_outlined,
                //     label: '1,376',
                //     onTap: (){},
                //   ),
                // ),
                LabelIconButton(
                  iconData: Icons.thumb_up_outlined,
                  label: '2,256',
                  onTap: () {},
                ),
                LabelIconButton(
                  iconData:
                      issue.isSubscribed
                          ? Icons.bookmark
                          : Icons.bookmark_add_outlined,
                  label: '구독',
                  onTap: widget.manageIssueSubscription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShortsInnerPage extends StatelessWidget {
  const ShortsInnerPage({
    super.key,
    required this.bias,
    required this.issueId,
    required this.text,
    required this.keywords,
  });

  final Bias bias;
  final String text;
  final String issueId;
  final List<String> keywords;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MyPaddings.medium),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: getBiasColor(bias).withOpacity(0.2),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: MyPaddings.medium,
            vertical: MyPaddings.medium,
          ),
          child: SingleChildScrollView(
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
          ),
        ),
      ],
    );
  }
}
