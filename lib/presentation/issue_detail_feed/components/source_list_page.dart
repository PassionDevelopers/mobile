import 'dart:developer';

import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/articles_group_by_bias.dart';
import 'package:could_be/presentation/media/media_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/bias/bias_enum.dart';
import '../../../core/components/cards/issue_detail_title_card.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../ui/color.dart';

class SourceListPage extends StatefulWidget {
  const SourceListPage({
    super.key,
    required this.articlesGBBAS,
    required this.toNextIssue,
    required this.hasNextIssue,
  });

  final ArticlesGroupByBiasAndSource articlesGBBAS;
  final VoidCallback toNextIssue;
  final bool hasNextIssue;

  @override
  State<SourceListPage> createState() => _SourceListPageState();
}

class _SourceListPageState extends State<SourceListPage>
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

  Bias currentBias = Bias.center;
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

  _buildTabViewPage({required Bias bias, required List<OneSourceArticles> oneSourceArticles}) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MyPaddings.large),
      child: TextCard(
        color: getBiasColor(bias),
        child:
        oneSourceArticles.isEmpty
                ? NotFound(notFoundType: NotFoundType.article)
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (final oneSourceArticle in oneSourceArticles)
                        MediaChatBubble(
                          articles: oneSourceArticle.articles,
                          toWebView: (String aritcleId) {
                            context.push(
                              RouteNames.webView,
                              extra: {
                                'articleInfo': (
                                  widget.articlesGBBAS.allArticles,
                                  aritcleId,
                                  oneSourceArticle.source.id,
                                ),
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
      ),
    );
  }

  late final List<OneSourceArticles>? leftArticles =
      widget.articlesGBBAS.oneSourceArticlesByBias[Bias.left];
  late final List<OneSourceArticles>? centerArticles =
      widget.articlesGBBAS.oneSourceArticlesByBias[Bias.center];
  late final List<OneSourceArticles>? rightArticles =
      widget.articlesGBBAS.oneSourceArticlesByBias[Bias.right];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.addListener(() {
      setState(() {});
    });
    log('SourceListPage initState');
    log('Left Articles: ${widget.articlesGBBAS.allArticles.length}');
    log('Left Articles: ${leftArticles?.length}');
    log('Center Articles: ${centerArticles?.length}');
    log('Right Articles: ${rightArticles?.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row(
        //   children: [
        //     BackButton(),
        //     BigTitle(title: '원문 기사 보기'),
        //   ],
        // ),
        IssueDetailTitleCard(
          icon: Icon(Icons.newspaper),
          title: BigTitle(title: '원문 기사 보기'),
        ),

        SizedBox(height: MyPaddings.medium),
        Column(
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
            SizedBox(height: MyPaddings.large),
            AutoSizedTabBarView( tabController: _tabController,
              children: [
                _buildTabViewPage(bias: Bias.left, oneSourceArticles: leftArticles ?? []),
                _buildTabViewPage(
                  bias: Bias.center,
                  oneSourceArticles: centerArticles ?? [],
                ),
                _buildTabViewPage(bias: Bias.right, oneSourceArticles: rightArticles ?? []),
              ],),

            SizedBox(height: MyPaddings.medium),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MyPaddings.large),
              child: BigButton(
                widget.hasNextIssue? '다음 이슈 보기' : '홈으로 돌아가기',
                backgroundColor: AppColors.primary,
                textColor: AppColors.primaryLight,
                onPressed: widget.hasNextIssue? widget.toNextIssue : (){
                  context.pop();
                },
              ),
            ),
          ],
        ),
        SizedBox(height: MyPaddings.medium),
      ],
    );
  }
}
