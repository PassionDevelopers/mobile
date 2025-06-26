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
  const ShortsComponent({super.key, required this.issue, required this.manageIssueSubscripton});

  final IssueDetail issue;
  final VoidCallback manageIssueSubscripton;

  @override
  State<ShortsComponent> createState() => _ShortsComponentState();
}

class _ShortsComponentState extends State<ShortsComponent> with TickerProviderStateMixin {
  Bias currentBias = Bias.center;
  late final IssueDetail issue = widget.issue;
  late final TabController _tabController = TabController(
    length: 3,
    initialIndex: 1,
    vsync: this,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {
        currentBias = [Bias.left, Bias.center, Bias.right][_tabController.index];
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  Tab tab(Bias bias){
    return Tab(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BiasLabel(
          mainAxisAlignment: MainAxisAlignment.center,
          color: getBiasColor(bias),
          label: getBiasName(bias, suffix: '매체'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MyPaddings.medium),
      color: AppColors.primaryLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(child: MyText.h1(issue.title)),
                  IconButton(
                    icon: Icon(
                        issue.isSubscribed? Icons.bookmark :
                          Icons.bookmark_add_outlined, color: AppColors.gray3),
                    onPressed: (){
                      widget.manageIssueSubscripton();
                    },
                  )
                ],
              ),
              IssueInfoTitle(
                mediaTotal: issue.coverageSpectrum.total,
                viewCount: issue.view,
                time: issue.updatedAt ?? issue.createdAt,
              ),
            ],
          ),
          SizedBox(height: MyPaddings.small),
          // 언론사 분포 바
          // CardBiasBar(coverageSpectrum: issue.coverageSpectrum),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.gray5,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TabBar(
                    tabAlignment: TabAlignment.fill,
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    // labelPadding: EdgeInsets.zero,
                    // padding: EdgeInsets.zero,
                    // unselectedLabelColor: AppColors.gray3,
                    // labelColor: AppColors.gray1,
                    // labelStyle: MyFontStyle.h2,
                    // unselectedLabelStyle: MyFontStyle.reg,
                    indicator: BoxDecoration(
                      color: getBiasColor([Bias.left, Bias.center, Bias.right][_tabController.index]).withAlpha(80),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // indicatorColor: AppColors.gray3,
                    tabs: [
                      tab(Bias.left),
                      tab(Bias.center),
                      tab(Bias.right),
                    ],
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
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
                          color: getBiasColor(bias),
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
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(MyPaddings.medium),
            decoration: BoxDecoration(
              color: getBiasColor(bias).withAlpha(50),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.newspaper_rounded,
                    label: '원문 기사',
                    onTap: () {
                      context.push(RouteNames.webView, extra: {
                        'isIssueId' : true, 'issueId' : issueId, 'bias': bias,
                      });
                    },
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.balance,
                    label: '차이점 분석',
                    onTap: (){},
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.comment,
                    label: '1,376',
                    onTap: (){},
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.thumb_up,
                    label: '2,256',
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

