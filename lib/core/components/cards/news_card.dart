import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/domain/entities/article.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ui/color.dart';
import '../../method/date_time_parsing.dart';
import '../../themes/margins_paddings.dart';
import '../../responsive/responsive_utils.dart';

class NewsCard extends StatefulWidget {
  final Article article;
  final VoidCallback? onWebViewSelected;
  final bool? isSelected;

  const NewsCard({
    super.key,
    required this.article,
    this.onWebViewSelected,
    this.isSelected,
  });

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



  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      // TODO: implement dispose
      _animationController.dispose();
      super.dispose();
    }

    final responsiveMargin = ResponsiveUtils.getResponsiveMargin(
      context,
      mobile: MyPaddings.small.toDouble(),
      tablet: MyPaddings.medium.toDouble(),
      desktop: MyPaddings.large.toDouble(),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: responsiveMargin.left),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: widget.isSelected == true ? AppColors.black.withAlpha(50) : null,

      ),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.isMobile(context) ? MyPaddings.medium.toDouble() : MyPaddings.large.toDouble(),
        vertical: ResponsiveUtils.isMobile(context) ? MyPaddings.small.toDouble() : MyPaddings.medium.toDouble(),
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
                // context.push('/shortsView/${widget.issue.id}');
              },
              onTapCancel: () => _animationController.reverse(),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (widget.onWebViewSelected != null) {
                    widget.onWebViewSelected!();
                  } else {
                    context.push(
                      RouteNames.webView,
                      extra: {
                        'articleInfo': (
                          [widget.article],
                          widget.article.id,
                          widget.article.source.id,
                        ),
                      },
                    );
                  }
                },
                child: Ink(
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
                  child: Row(
                    children: [
                      Container(
                        height: ResponsiveUtils.isMobile(context) ? 100 : 120,
                        width: ResponsiveUtils.isMobile(context) ? 100 : 120,
                        padding: EdgeInsets.all(ResponsiveUtils.isMobile(context) ? MyPaddings.extraSmall.toDouble() : MyPaddings.small.toDouble()),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: ImageContainer(
                            borderRadius: BorderRadius.circular(16),
                            height: ResponsiveUtils.isMobile(context) ? 100 : 120,
                            imageUrl: widget.article.imageUrl,
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(MyPaddings.small),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.h2(widget.article.title, maxLines: 5),
                              SizedBox(height: MyPaddings.small),
                              MyText.reg(
                                widget.article.source.name +
                                    ' · ' +
                                    getTimeAgo(widget.article.publishedAt),
                              ),
                            ],
                          ),
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
