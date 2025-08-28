import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/user_profile.dart';
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

  Widget changeAbsoluteButton(bool isAbsolute) {
    final bool isSelected = viewModel.state.isHexagonAbsolute == isAbsolute;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          viewModel.changeHexagonZoom(isAbsolute);
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
                  child: Text(isAbsolute? '절대 평가' : '상대 평가'),
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
        final wholeBiasScore = state.wholeBiasScore;
        final UserProfile? bias = state.userProfile;
        return Ink(
          padding: EdgeInsets.fromLTRB(
              MyPaddings.extraLarge,
              MyPaddings.extraLarge,
              MyPaddings.extraLarge,
              MyPaddings.extraLarge,
          ),
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
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText.reg('나의 성향', color: AppColors.gray2),
                        SizedBox(height: MyPaddings.small),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color:
                                    bias == null
                                        ? AppColors.gray5
                                        : getBiasColor(bias.bias),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: MyPaddings.small),
                            MyText.h1(
                              bias == null ? '' : getBiasName(bias.bias),
                              color: AppColors.primary,
                            ),
                            if(bias != null) GestureDetector(
                              onTap: () {
                                viewModel.fetchWholeBiasScore();
                              },
                              child: Icon(Icons.refresh, size: 25, color: AppColors.gray2)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                        bias == null
                            ? AppColors.gray5
                            : getBiasColor(bias.bias).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: bias == null ? null : getBiasIcon(bias.bias),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MyPaddings.large),

              // Radar Chart
              SizedBox(
                height: 300,
                child:
                  wholeBiasScore == null || state.isWholeBiasScoreLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                      : BiasHexagon(
                        isZoomed: viewModel.state.isHexagonAbsolute,
                        wholeBiasScore: wholeBiasScore,
                        onBiasChanged: viewModel.changeBiasNow,
                        biasNow: state.biasNow,
                      ),
              ),

              SizedBox(height: MyPaddings.large),

              Container(
                height: 35,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.gray5,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    changeAbsoluteButton(true),
                    changeAbsoluteButton(false),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
