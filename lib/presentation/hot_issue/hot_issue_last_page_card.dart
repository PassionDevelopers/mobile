import 'dart:math' as math;
import 'package:could_be/core/method/share_dasi_stand.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class HotIssueLastPageCard extends StatefulWidget {
  const HotIssueLastPageCard({super.key, this.issueCount = 0});

  final int issueCount;

  @override
  State<HotIssueLastPageCard> createState() => _HotIssueLastPageCardState();
}

class _HotIssueLastPageCardState extends State<HotIssueLastPageCard>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _sparkleController;
  late AnimationController _pulseController;
  late Animation<double> _sparkleAnimation;

  @override
  void initState() {
    super.initState();

    // 메인 애니메이션
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // 스파클 애니메이션
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    )..repeat();

    // 펄스 애니메이션
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _sparkleAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(_sparkleController);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _sparkleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // 스파클 효과
  Widget _buildSparkles() {
    return AnimatedBuilder(
      animation: _sparkleAnimation,
      builder: (context, child) {
        return Stack(
          children: List.generate(15, (index) {
            final angle = (index * 2 * math.pi / 15) + _sparkleAnimation.value;
            final radius = 120 + (index % 3) * 20;
            final x = 150 + radius * math.cos(angle);
            final y = 200 + radius * math.sin(angle);

            return Positioned(
              left: x,
              top: y,
              child: Transform.scale(
                scale:
                    0.5 + 0.5 * math.sin(_sparkleAnimation.value * 3 + index),
                child: Icon(
                  Icons.star,
                  size: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MyPaddings.medium,
        bottom: MyPaddings.extraLarge,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.primary,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 스파클 효과
            _buildSparkles(),

            // 메인 콘텐츠
            Padding(
              padding: EdgeInsets.all(MyPaddings.extraLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 레벨업 배지
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MyPaddings.medium,
                      vertical: MyPaddings.small,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.4),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      '시사 충전 완료!',
                      style: MyFontStyle.reg.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  SizedBox(height: MyPaddings.large),

                  // 트로피 아이콘 - 더 화려하게
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.bounceOut,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 외부 글로우
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            // 메인 트로피 배경
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.4),
                                    Colors.white.withValues(alpha: 0.2),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  width: 3,
                                ),
                              ),
                              child: Icon(
                                Icons.emoji_events_rounded,
                                size: 70,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: MyPaddings.largeMedium),

                  Text(
                    '오늘의 주요 이슈를\n모두 확인했어요!',
                    textAlign: TextAlign.center,
                    style: MyFontStyle.h2.copyWith(
                      color: Colors.white.withValues(alpha: 0.95),
                      height: 1.6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: MyPaddings.extraLarge),

                  // CTA 버튼들 - 더 화려하게
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white.withValues(alpha: 0.9),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.3),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              shareDasiStand();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: AppColors.center,
                              padding: EdgeInsets.symmetric(
                                vertical: MyPaddings.large,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.share_rounded,
                                  color: AppColors.primary.withValues(alpha: 0.9),
                                  size: 20,
                                ),
                                SizedBox(width: MyPaddings.small),
                                Text(
                                  '다시 스탠드 공유하기',
                                  style: MyFontStyle.h3.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: MyPaddings.medium),

                  // 공유 버튼
                  TextButton(
                    onPressed: () {
                      context.go(RouteNames.home);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: MyPaddings.large,
                        vertical: MyPaddings.medium,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home_rounded,
                          size: 20,
                          color: AppColors.white,
                        ),
                        SizedBox(width: MyPaddings.small),
                        Text(
                          '홈으로 돌아가기',
                          style: MyFontStyle.h3.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
