
import 'package:could_be/core/themes/fonts.dart';
import 'package:could_be/core/themes/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/themes/margins_paddings.dart';


class MediaDetailLoadingView extends StatelessWidget {
  const MediaDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: MyPaddings.large),
        // 언론 정보 카드
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),

        const SizedBox(height: MyPaddings.large),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.h3('평가 결과', color: AppColors.primary),
              const SizedBox(height: MyPaddings.medium),
              _buildEvaluationItem(Icons.assessment),
              _buildEvaluationItem(Icons.psychology),
              _buildEvaluationItem(Icons.verified_user),
              _buildEvaluationItem(Icons.people_outline),
            ],
          ),
        ),

        const SizedBox(height: MyPaddings.medium),

        // 사용자 평가 섹션
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: MyPaddings.small),
                  MyText.h3('나의 평가', color: AppColors.primary),
                ],
              ),
              const SizedBox(height: MyPaddings.medium),

              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  height: 150,
                  padding: EdgeInsets.all(MyPaddings.large),
                  decoration: BoxDecoration(
                    color: AppColors.gray400,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.gray300),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: MyPaddings.extraLarge),
      ],
    );
  }

  Widget _buildEvaluationItem(IconData icon) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: MyPaddings.medium),
        decoration: BoxDecoration(
          color: AppColors.gray400,
            borderRadius: BorderRadius.circular(12)),
    ));
  }
}
