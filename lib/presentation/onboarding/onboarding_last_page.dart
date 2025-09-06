import 'package:could_be/core/components/buttons/big_button.dart';
import 'package:could_be/core/components/cards/source_evaluate_card.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/routes/route_names.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingLastPage extends StatelessWidget {
  const OnboardingLastPage({super.key});

  Widget _buildCard({
    required String title,
    required String subTitle,
    required Widget child,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: MyPaddings.large),
        child: Ink(
          padding: const EdgeInsets.all(MyPaddings.large),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.gray4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.h2(title),
              const SizedBox(height: MyPaddings.small),
              MyText.h3(
                subTitle,
                maxLines: 1,
                color: AppColors.gray3,
              ),
              const SizedBox(height: MyPaddings.small),
              Expanded(child: Center(child: child))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard(
            title: '나의 성향 선택',
            subTitle: '이미 자신의 성향을 알고 게신가요?',
            child: SourceEvaluationRow(
              userEvaluatedPerspective: Bias.center.toPerspective(),
              onBiasSelected: (String bias) {},
            ),
          ),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: MyPaddings.medium,
                ),
                child: MyText.h1('또는'),
              ),
              Expanded(child: Divider()),
            ],
          ),
          _buildCard(
            title: '성향 테스트',
            subTitle: '아직 자신의 성향을 잘 모르시나요?',
            child:  BigButton(
              backgroundColor: AppColors.primaryLight,
              textColor: AppColors.primary,
              onPressed: () {
                context.go(RouteNames.biasTest);
              },
              text: '테스트를 통해 알아보기',
            ),
          ),
        ],
      ),
    );
  }
}
