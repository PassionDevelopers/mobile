import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/presentation/media/media_profile_component.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/method/bias/bias_enum.dart';
import '../../../core/components/cards/news_card.dart';
import '../../../core/themes/margins_paddings.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/components/layouts/responsive_grid.dart';
import 'media_detail_view_model.dart';

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
                borderRadius: BorderRadius.circular(16),
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
                    color: AppColors.gray4,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.gray5),
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
          color: AppColors.gray4,
            borderRadius: BorderRadius.circular(12)),
    ));
  }
}
