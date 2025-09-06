import 'dart:developer';

import 'package:could_be/core/components/layouts/text_helper.dart';
import 'package:could_be/core/components/loading/not_found.dart';
import 'package:could_be/domain/entities/articles_group_by_bias.dart';
import 'package:could_be/presentation/media/media_components.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../ui/color.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MyPaddings.medium),
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
                  bottom: BorderSide(color: AppColors.gray5, width: 1),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.newspaper, color: AppColors.primary, size: 24),
                  SizedBox(width: MyPaddings.medium),
                  MyText.h2(
                    '원문 기사 보기',
                    color: AppColors.primary,
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
            ),
        ],
      ),
    );
  }
}
