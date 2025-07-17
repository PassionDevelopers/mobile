import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/presentation/my_page/components/my_bias_status_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class MyPageHexagon extends StatelessWidget {
  const MyPageHexagon({super.key, required this.viewModel});
  final MyPageViewModel viewModel;

  String getCreatedDate(WholeBiasScore? wholeBiasScore) {
    final date = wholeBiasScore?.createdAt;
    if (date == null) return '알 수 없음';
    return '${date.year}년 ${date.month}월 ${date.day}일 ${date.hour}시 ${date.minute}분';
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final state = viewModel.state;
        if (state.isBiasLoading || state.userBias == null) {
          return SizedBox.shrink();
        }
        final wholeBiasScore = state.wholeBiasScore;
        final bias = state.userBias!.bias;
        return Container(
          padding: EdgeInsets.all(MyPaddings.extraLarge),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray3.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.reg('나의 성향', color: AppColors.gray2),
                      SizedBox(height: MyPaddings.small),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: getBiasColor(bias),
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: MyPaddings.small),
                          MyText.h1(getBiasName(bias), color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: getBiasColor(bias).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: getBiasIcon(bias),
                  ),
                ],
              ),

              SizedBox(height: MyPaddings.large),

              // Radar Chart
              wholeBiasScore == null?
              Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ) :
              SizedBox(height: 300, child: BiasHexagon(
                wholeBiasScore: wholeBiasScore,
                onBiasChanged: viewModel.changeBiasNow,
                biasNow: state.biasNow,
              )),

              SizedBox(height: MyPaddings.large),

              // Description
              InkWell(
                onTap: viewModel.fetchWholeBiasScore,
                child: Ink(
                  padding: EdgeInsets.symmetric(
                    horizontal: MyPaddings.large,
                    vertical: MyPaddings.medium,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray5,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.refresh, color: AppColors.gray2, size: 18),
                      SizedBox(width: MyPaddings.medium),
                      Expanded(child: MyText.small('마지막 새로고침: ${getCreatedDate(wholeBiasScore)}')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
