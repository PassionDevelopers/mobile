import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HotIssueCard extends StatefulWidget {
  const HotIssueCard({super.key, required this.updateTime, required this.hotIssues});

  final DateTime updateTime;
  final HotIssues hotIssues;

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
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final responsivePadding = ResponsiveUtils.getResponsivePadding(
    //   context,
    //   mobile: MyPaddings.medium.toDouble(),
    //   tablet: MyPaddings.large.toDouble(),
    //   desktop: MyPaddings.medium.toDouble(),
    // );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MyPaddings.largeMedium.toDouble(),
        0,
        MyPaddings.largeMedium.toDouble(),
        MyPaddings.medium.toDouble(),
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
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  context.push(RouteNames.hotIssueFeed, extra: widget.hotIssues);
                  UnifiedAnalyticsHelper.logEvent(name: AnalyticsEventNames.openHotIssues);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // 배경 그라데이션
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primary.withValues(alpha: 0.9),
                              AppColors.primary.withValues(alpha: 0.8),
                            ],
                          ),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: AppColors.gray4,
                          //     spreadRadius: 10,
                          //     blurRadius: 30,
                          //     offset: Offset(0, 10), // changes position of shadow
                          //   ),
                          // ],
                        ),
                      ),
                      // 글래스모피즘 효과
                      Container(
                        width: double.infinity,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(MyPaddings.large),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 상단 헤더
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.reg('${formatDateTimeToMinute(widget.hotIssues.hotTime)} 업데이트', color: AppColors.gray4),
                                  // 화살표 버튼
                                  Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                              const Spacer(),

                              // 하단 텍스트

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.h2('바쁘신가요?', color: AppColors.primaryLight),
                                  MyText.h1('이것만 보세요.', color: AppColors.primaryLight),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: -17,
                        bottom: -17,
                        child: Transform.rotate(
                          angle: -0.2,
                            child: Icon(Icons.alarm, color: AppColors.primaryLight, size: 100,)))
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
