import 'package:could_be/core/components/image/image_container.dart';
import 'package:could_be/core/responsive/responsive_utils.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

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
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  // Navigation logic here
                },
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
                      ),
                    ),
                    // 글래스모피즘 효과
                    Container(
                      width: double.infinity,
                      height: 140,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   gradient: LinearGradient(
                      //     begin: Alignment.topCenter,
                      //     end: Alignment.bottomCenter,
                      //     colors: [
                      //       Colors.white.withValues(alpha: 0.1),
                      //       Colors.white.withValues(alpha: 0.05),
                      //     ],
                      //   ),
                      //   border: Border.all(
                      //     color: Colors.white.withValues(alpha: 0.2),
                      //     width: 1.5,
                      //   ),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: AppColors.primary.withValues(alpha: 0.15),
                      //       blurRadius: 20,
                      //       spreadRadius: 0,
                      //       offset: Offset(0, 10),
                      //     ),
                      //   ],
                      // ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(MyPaddings.large),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 상단 헤더
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // HOT 뱃지와 타이틀
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // 애니메이션 HOT 뱃지
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: MyPaddings.small,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.white.withValues(alpha: 0.3),
                                                    blurRadius: 8,
                                                    spreadRadius: 0,
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.whatshot,
                                                    size: 14,
                                                    color: AppColors.right,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  MyText.small(
                                                    'HOT',
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: MyPaddings.small),
                                            MyText.h2(
                                              '오늘의 이슈 TOP 5',
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: MyPaddings.extraSmall),

                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Colors.white.withValues(alpha: 0.7),
                                            ),
                                            const SizedBox(width: 4),
                                            MyText.small(
                                              '실시간 업데이트',
                                              color: Colors.white.withValues(alpha: 0.7),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
                                  MyText.reg(
                                    '지금 가장 핫한',
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                  MyText.h1(
                                    '실시간 이슈 모음',
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}