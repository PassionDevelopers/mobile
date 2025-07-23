import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/responsive/responsive_utils.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class HotIssueCard extends StatefulWidget {
  const HotIssueCard({super.key});

  @override
  State<HotIssueCard> createState() => _HotIssueCardState();
}

class _HotIssueCardState extends State<HotIssueCard>
    with SingleTickerProviderStateMixin {
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

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsivePadding = ResponsiveUtils.getResponsivePadding(
      context,
      mobile: MyPaddings.largeMedium.toDouble(),
      tablet: MyPaddings.large.toDouble(),
      desktop: MyPaddings.medium.toDouble(),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        responsivePadding.left,
        0,
        responsivePadding.right,
        responsivePadding.bottom,
      ),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) {
                _animationController.reverse();
              },
              onTapCancel: () => _animationController.reverse(),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  // context.push(
                  //   RouteNames.issueDetailFeed,
                  //   extra: widget.issue.id,
                  // );
                },
                child: Ink(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryLight,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gray4,
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: MyPaddings.large),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MyPaddings.large,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    MyText.h2('오늘의 이슈 Top 5'),
                                    const SizedBox(width: MyPaddings.small),
                                    Icon(Icons.info_outline, size: 18),
                                  ],
                                ),
                                const SizedBox(height: MyPaddings.extraSmall),
                                MyText.reg(
                                  '2025년 7월 22일 19:53 기준',
                                  color: AppColors.gray3,
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, size: 20,)
                          ],
                        ),
                      ),
                      // const SizedBox(height: MyPaddings.small),
                      // MyText.h3('오늘 가장 많은 언론이 보도한 이슈 몰아보기', maxLines: 3),

                      const SizedBox(height: MyPaddings.small),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: MyPaddings.large,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Material(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                                color: AppColors.white,
                                child: SizedBox(
                                  width: 80,
                                  child: ImageContainer(
                                    height: 80,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    imageUrl:
                                        'https://dasi-news-images.s3.ap-northeast-2.amazonaws.com/issues/2025/07/23/20716_639501d2.png',
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 5,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),

                      const SizedBox(height: MyPaddings.large),
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
