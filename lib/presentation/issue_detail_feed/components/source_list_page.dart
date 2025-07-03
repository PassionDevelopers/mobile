import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/articles_group_by_bias.dart';
import 'package:could_be/presentation/media/media_components.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/components/bias/bias_enum.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../domain/entities/article.dart';
import '../../../ui/color.dart';

class SourceListPage extends StatefulWidget {
  const SourceListPage({super.key, required this.articles});
  final ArticlesGroupByBias articles;

  @override
  State<SourceListPage> createState() => _SourceListPageState();
}

class _SourceListPageState extends State<SourceListPage> with TickerProviderStateMixin{

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

  _buildTabViewPage({
    required Bias bias,
    required List<Article> biasArticles,
  }) {
    return TextCard(
      color: getBiasColor(bias),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MyPaddings.medium),
          for(final article in biasArticles)
            MediaChatBubble(article: article, toWebView: (){
              context.push(RouteNames.webView,
                  extra: {'articleInfo' : (widget.articles.allArticles, article.id, article.source.id) });
            },),
          SizedBox(height: MyPaddings.medium),
        ],
      ),
    );
  }

  late final List<Article> leftArticles = widget.articles.articlesByBias[Bias.left]!;
  late final List<Article> centerArticles = widget.articles.articlesByBias[Bias.center]!;
  late final List<Article> rightArticles = widget.articles.articlesByBias[Bias.right]!;

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigTitle(title: '원문 기사 보기'),
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
                biasArticles: leftArticles,
              ),
              _buildTabViewPage(
                bias: Bias.center,
                biasArticles: centerArticles,
              ),
              _buildTabViewPage(
                bias: Bias.right,
                biasArticles: rightArticles,
              ),
            ],
          ),
        ),
        SizedBox(height: MyPaddings.medium),
        BigButton('다음 이슈 보기',
          backgroundColor: AppColors.primary,
          textColor: AppColors.primaryLight,
            onPressed: (){

        }),
        SizedBox(height: MyPaddings.medium),
      ],
    );
  }
}
