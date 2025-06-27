import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/issue_info_title.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/components/bias/bias_enum.dart';
import '../../../core/components/buttons/label_icon_button.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../ui/fonts.dart';

class NewsFeedCard extends StatefulWidget {
  final IssueDetail content;
  final bool isActive;
  final VoidCallback? onSubscribeToggle;
  final VoidCallback? onShare;
  final VoidCallback? onBack;
  final VoidCallback? onViewArticle;
  final VoidCallback? onAnalyzeDifference;

  const NewsFeedCard({
    super.key,
    required this.content,
    required this.isActive,
    this.onSubscribeToggle,
    this.onShare,
    this.onBack,
    this.onViewArticle,
    this.onAnalyzeDifference,
  });

  @override
  State<NewsFeedCard> createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard>
    with TickerProviderStateMixin {
  int _selectedBiasIndex = 1; // 기본값: 중도
  bool _showKeywords = false;

  final List<Color> _biasColors = [
    AppColors.left,
    AppColors.center,
    AppColors.right,
    // const Color(0xFFE53E3E), // 진보 - 빨강
    // const Color(0xFF38A169), // 중도 - 초록
    // const Color(0xFF3182CE), // 보수 - 파랑
  ];

  final List<String> _biasLabels = ['진보', '중도', '보수'];

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(12.0),
      topRight: Radius.circular(12.0),
    );
    double maxHeight = MediaQuery.of(context).size.height;
    double minHeight = maxHeight -250;
    return MyScaffold(body: SlidingUpPanel(
      panel: _buildNewsCard(),
      minHeight: minHeight,
      maxHeight: maxHeight,
      body: Column(
        children: [
          Image.network(
            widget.content.imageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
          Expanded(child: SizedBox())
        ],
      ),
      borderRadius: radius,
    ));
  }

  Widget _buildNewsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MyPaddings.small, horizontal: MyPaddings.large),
            child: MyText.h1(widget.content.title, maxLines: 3),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
            child: IssueInfoTitle(
              mediaTotal: widget.content.coverageSpectrum.total,
              viewCount: widget.content.view,
              time: widget.content.updatedAt ?? widget.content.createdAt,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: List.generate(3, (index) {
                final isSelected = index == _selectedBiasIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedBiasIndex = index;
                        _showKeywords = false;
                      });
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
                        '${_biasLabels[index]} 매체',
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
              }),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildSummaryText(),
              ),
            ),
          ),
          Ink(
            height: 160,
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
                      extra: {'issueInfo': (widget.content.id, Bias.center)},
                    );
                  },
                ),
                LabelIconButton(
                  iconData: Icons.balance_outlined,
                  label: '차이점 분석',
                  onTap: () {
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
                  widget.content.isSubscribed
                      ? Icons.bookmark
                      : Icons.bookmark_add_outlined,
                  label: '구독',
                  onTap: (){},
                  // onTap: widget.manageIssueSubscription,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryText() {
    final summaries = [
      widget.content.leftSummary,
      widget.content.centerSummary,
      widget.content.rightSummary,
    ];

    final keywords = [
      widget.content.leftKeywords,
      widget.content.centerKeywords,
      widget.content.rightKeywords,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _biasColors[_selectedBiasIndex].withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          if (_showKeywords) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _biasColors[_selectedBiasIndex].withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    keywords[_selectedBiasIndex].map((keyword) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _biasColors[_selectedBiasIndex],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _biasColors[_selectedBiasIndex]
                                  .withOpacity(0.3),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          keyword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summaries[_selectedBiasIndex],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        height: 1.7,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      height: 70,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: _buildPrimaryButton(
              '원문 기사',
              Icons.article_outlined,
              _biasColors[_selectedBiasIndex],
              widget.onViewArticle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildPrimaryButton(
              '차이점 분석',
              Icons.analytics_outlined,
              Colors.grey[700]!,
              widget.onAnalyzeDifference,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
