import 'package:could_be/ui/color_styles.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/issue.dart';
import '../../../ui/color.dart';
import '../../themes/margins_paddings.dart';
import '../bias/bias_bar.dart';
import '../chips/key_word_chip_component.dart';

class NewsCard extends StatefulWidget {
  final Issue issue;
  final bool isDailyIssue;

  const NewsCard({super.key, required this.issue, required this.isDailyIssue});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  );
  late final Animation<double> _scaleAnimation = Tween<double>(
    begin: 1.0,
    end: 1.05,
  ).animate(
    CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  );

  ani() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) => _animationController.forward(),
            onTapUp: (_) {
              _animationController.reverse();
              context.push('/shortsView/${widget.issue.id}');
            },
            onTapCancel: () => _animationController.reverse(),
            child: Container(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium, vertical: MyPaddings.small),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) {
                _animationController.reverse();
                context.push('/shortsView/${widget.issue.id}');
              },
              onTapCancel: () => _animationController.reverse(),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  context.push('/shortsView/${widget.issue.id}');
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryLight,
                  ),
                  child: Column(
                    children: [
                      if (widget.issue.imageUrl != null)
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.network(
                              widget.issue.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          MyPaddings.large,
                          MyPaddings.medium,
                          MyPaddings.large,
                          MyPaddings.large,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(child: MyText.h2(widget.issue.title)),
                                // if (issue.getBlindSpot() != null) BlindChip(isRightBlind: issue.getBlindSpot()!, )
                              ],
                            ),
                            SizedBox(height: MyPaddings.large),
                            SizedBox(
                              height: 26,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (_, index) {
                                  return KeyWordChip(
                                    title: widget.issue.keywords[index],
                                  );
                                },
                                itemCount: widget.issue.keywords.length,
                                shrinkWrap: true,
                              ),
                            ),
                            // Bias Bar
                            SizedBox(height: MyPaddings.medium),
                            CardBiasBar(
                              coverageSpectrum: widget.issue.coverageSpectrum,
                            ),
                            SizedBox(height: MyPaddings.medium),
                            Row(
                              children: [
                                Icon(
                                  Icons.article_outlined,
                                  size: 16,
                                  color: ColorStyles.gray1,
                                ),
                                SizedBox(width: 4),
                                MyText.reg(
                                  '${widget.issue.coverageSpectrum.total}개 매체',
                                  color: ColorStyles.gray1,
                                ),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: ColorStyles.gray1,
                                ),
                                SizedBox(width: 4),
                                MyText.reg(
                                  widget.issue.getTimeAgo(),
                                ),
                                SizedBox(width: 16),
                                Icon(
                                  Icons.visibility,
                                  size: 16,
                                  color: ColorStyles.gray1,
                                ),
                                SizedBox(width: 4),
                                MyText.reg(
                                  widget.issue.view.toString(),
                                  color: ColorStyles.gray1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
