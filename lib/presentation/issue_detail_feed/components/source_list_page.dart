import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/domain/entities/article/articles_group_by_bias.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_box.dart';
import 'package:could_be/presentation/issue_detail_feed/components/sector_title.dart';
import 'package:could_be/presentation/source/components/source_chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../core/themes/color.dart';

class SourceListPage extends StatefulWidget {
  const SourceListPage({
    super.key,
    required this.articlesGBBAS,
    required this.toNextIssue,
    required this.hasNextIssue,
    required this.isSpread,
    required this.spreadCallback,
  });

  final ArticlesGroupByBiasAndSource articlesGBBAS;
  final VoidCallback toNextIssue;
  final bool hasNextIssue;
  final bool isSpread;
  final VoidCallback spreadCallback;

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

  // _buildTab(int index) {
  //   final isSelected = index == _tabController.index;
  //
  //   return Expanded(
  //     child: GestureDetector(
  //       onTap: () {
  //         _tabController.animateTo(index);
  //       },
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 200),
  //         margin: const EdgeInsets.all(2),
  //         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
  //         decoration: BoxDecoration(
  //           color: isSelected ? _biasColors[index] : Colors.transparent,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Text(
  //           '${_biasLabels[index]} 언론',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: isSelected ? Colors.white : AppColors.gray600,
  //             fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  _buildTabViewPage({
    required Bias bias,
    required List<OneSourceArticles> oneSourceArticles,
  }) {
    return oneSourceArticles.isEmpty
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
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectorBox(
      content: Column(
        children: [
          SectorTitle(
            title: '원문 기사 보기',
            icon: Icons.newspaper,
            onTap: widget.spreadCallback,
            isSpread: widget.isSpread,
          ),
          if (widget.isSpread) SizedBox(height: MyPaddings.medium),
          if (widget.isSpread)
            Column(
              children: [
                TabBar(
                  automaticIndicatorColorAdjustment: false,
                  controller: _tabController,
                  tabs: List.generate(3, (index) {
                    return Tab(
                      child: Text(
                        _biasLabels[index],
                      ),
                    );
                  }),
                  labelColor: _biasColors[_tabController.index],
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: _biasColors[_tabController.index],
                ),
                SizedBox(height: MyPaddings.large),
                AutoSizedTabBarView(
                  tabController: _tabController,
                  children: [
                    _buildTabViewPage(
                      bias: Bias.left,
                      oneSourceArticles: leftArticles ?? [],
                    ),
                    _buildTabViewPage(
                      bias: Bias.center,
                      oneSourceArticles: centerArticles ?? [],
                    ),
                    _buildTabViewPage(
                      bias: Bias.right,
                      oneSourceArticles: rightArticles ?? [],
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
