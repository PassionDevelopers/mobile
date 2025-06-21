import 'package:flutter/material.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../core/components/bias/bias_label.dart';
import '../../core/components/bias/bias_method.dart';
import '../../core/components/buttons/label_icon_button.dart';
import '../../core/components/chips/key_word_chip_component.dart';
import '../../core/themes/margins_paddings.dart';
import '../../domain/entities/issue_detail.dart';
import '../../ui/color.dart';
import '../../ui/color_styles.dart';
import '../../ui/fonts.dart';

class ShortsComponent extends StatefulWidget {
  const ShortsComponent({super.key, required this.issue});
  final IssueDetail issue;
  @override
  State<ShortsComponent> createState() => _ShortsComponentState();
}

class _ShortsComponentState extends State<ShortsComponent> {
  Bias currentBias = Bias.center;
  late final IssueDetail issue = widget.issue;
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
              MyText.h1(issue.title),
              SizedBox(height: MyPaddings.small),
              Row(
                children: [
                  Icon(Icons.article_outlined, size: 16, color: ColorStyles.gray1,),
                  SizedBox(width: 4),
                  MyText.reg(
                    '${issue.coverageSpectrum.total}개 매체',color: ColorStyles.gray1,
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, size: 16, color: ColorStyles.gray1,),
                  SizedBox(width: 4),
                  Text(
                    issue.getTimeAgo(),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.visibility, size: 16, color:  ColorStyles.gray1,),
                  SizedBox(width: 4),
                  MyText.reg(
                    issue.view.toString(),color: ColorStyles.gray1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: MyPaddings.small),
          // 언론사 분포 바
          // CardBiasBar(coverageSpectrum: issue.coverageSpectrum),
          Row(
            children: [
              BiasLabel(color: getBiasColor(currentBias), label: getBiasName(currentBias, suffix: '시각')),
            ],
          ),
          Expanded(
            child: DefaultTabController(length: 3, child: Column(
              children: [
                TabBar(
                  // indicator: BoxDecoration(
                  //   color: getBiasColor(currentBias).withAlpha(50),
                  //   borderRadius: BorderRadius.circular(12),
                  // ),
                  tabs: [
                    Tab(child: BiasLabel(color: getBiasColor(Bias.left), label: getBiasName(Bias.left, suffix: '시각')),),
                    Tab(child: BiasLabel(color: getBiasColor(Bias.center), label: getBiasName(Bias.center, suffix: '시각')),),
                    Tab(child: BiasLabel(color: getBiasColor(Bias.right), label: getBiasName(Bias.right, suffix: '시각')),),
                  ],
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                        ShortsInnerPage(bias: Bias.left, text: issue.leftSummary, keywords: issue.leftKeywords),
                        ShortsInnerPage(bias: Bias.center, text: issue.centerSummary, keywords: issue.centerKeywords),
                        ShortsInnerPage(bias: Bias.right, text: issue.rightSummary, keywords: issue.rightKeywords),
                      ],
                    )
                ),
              ],
            )),
          )
        ],
      ),
    );
  }
}

class ShortsInnerPage extends StatelessWidget {
  const ShortsInnerPage({super.key, required this.bias, required this.text, required this.keywords});
  final Bias bias;
  final String text;
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
                        return KeyWordChip(title: keywords[index], color: getBiasColor(bias),);
                      }, itemCount: keywords.length, shrinkWrap: true,),
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
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.balance,
                    label: '차이점 분석',
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.comment,
                    label: '1,376',
                  ),
                ),
                Flexible(
                  child: LabelIconButton(
                    iconData: Icons.thumb_up,
                    label: '2,256',
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

