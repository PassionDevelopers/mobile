import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../linear_chart_view.dart';

class MyPageTrendChart extends StatelessWidget {
  const MyPageTrendChart({super.key, required this.viewModel});
  final MyPageViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        if(state.isBiasScoreHistoryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                      MyText.h1('최근 ${state.biasScorePeriod.displayName}', color: AppColors.primary),
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
                child: DailyUserDataChart(
                  viewModel: viewModel,
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
      }
    );
  }
}
