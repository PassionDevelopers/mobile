import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../linear_chart_view.dart';

class MyPageTrendChart extends StatelessWidget {
  const MyPageTrendChart({super.key, required this.viewModel});

  final MyPageViewModel viewModel;

  Widget changePeriodButton({
    required BiasScorePeriod period,
  }) {
    final bool isSelected = viewModel.state.biasScorePeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          viewModel.changePeriod(period);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(17),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 12,),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected) Center(
                child: AnimatedContainer(
                  width: 8,
                  height: 8,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInToLinear,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInToLinear,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(period.displayName,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        return Container(
          padding: EdgeInsets.all(MyPaddings.extraLarge),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray3.withOpacity(0.05),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.small('성향 변화 추이', color: AppColors.gray2),
                      SizedBox(height: MyPaddings.small),
                      Row(
                        children: [
                          MyText.h1(
                            '최근 ${state.biasScorePeriod.displayName}',
                            color: AppColors.primary,
                          ),
                          if(state.biasScoreHistory != null) GestureDetector(
                              onTap: () {
                                viewModel.fetchBiasScoreHistory();
                              },
                              child: Icon(Icons.refresh, size: 25, color: AppColors.gray2)),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.trending_up,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MyPaddings.large),
              // Chart
              SizedBox(
                height: 300,
                child:
                    state.isBiasScoreHistoryLoading
                        ? Center(child: CircularProgressIndicator())
                        : DailyUserDataChart(viewModel: viewModel),
              ),
              Container(
                height: 35,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.gray5,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    changePeriodButton(period: BiasScorePeriod.weekly),
                    changePeriodButton(period: BiasScorePeriod.monthly),
                    changePeriodButton(period: BiasScorePeriod.yearly),
                  ],
                ),
              ),
              // // Summary
              // Container(
              //   margin: EdgeInsets.symmetric(
              //     horizontal: MyPaddings.extraLarge,
              //     vertical: MyPaddings.large,
              //   ),
              //   padding: EdgeInsets.all(MyPaddings.extraLarge),
              //   decoration: BoxDecoration(
              //     color: AppColors.gray5,
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: 4,
              //         height: 40,
              //         decoration: BoxDecoration(
              //           color: AppColors.primary,
              //           borderRadius: BorderRadius.circular(2),
              //         ),
              //       ),
              //       SizedBox(width: MyPaddings.medium),
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             MyText.h3('성향 변화 분석', color: AppColors.primary),
              //             SizedBox(height: MyPaddings.small),
              //             Text(
              //               '처음보다 더 균형 잡힌 관점으로 변화하고 있습니다.',
              //               style: MyFontStyle.reg.copyWith(
              //                 color: AppColors.gray2,
              //                 height: 1.4,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
