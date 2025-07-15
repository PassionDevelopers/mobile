import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

class BiasCheckButton extends StatelessWidget {
  const BiasCheckButton({super.key,
    required this.userEvaluation,
    required this.onBiasSelected,
    required this.leftLikeCount,
    required this.centerLikeCount,
    required this.rightLikeCount,
    required this.isEvaluating,
    required this.existLeft,
    required this.existCenter,
    required this.existRight,
  });

  final String? userEvaluation;
  final int leftLikeCount;
  final int centerLikeCount;
  final int rightLikeCount;
  final bool isEvaluating;
  final bool existLeft;
  final bool existCenter;
  final bool existRight;
  final void Function(Bias bias) onBiasSelected;

  _buildBiasCircle(Bias bias) {
    return Column(
      children: [
        MyText.reg(
          getBiasName(bias),
          color: getBiasColor(bias),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MyPaddings.small,
            // vertical: MyPaddings.small,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (!isEvaluating) onBiasSelected(bias);
            },
            child: Ink(
              height: 50,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: getBiasColor(bias)),
              ),
              child: Center(child: Icon(Icons.check, color: getBiasColor(bias))),
            ),
          ),
        ),
      ],
    );
  }

  _buildBiasRect(Bias bias) {
    int total = leftLikeCount + centerLikeCount + rightLikeCount;
    bool isSelected = userEvaluation == bias.toPerspective();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MyPaddings.small,
        vertical: MyPaddings.small,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          if (!isEvaluating) onBiasSelected(bias);
        },
        child: Ink(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [
                0,
                switch (bias) {
                  Bias.left => leftLikeCount / total,
                  Bias.center => centerLikeCount / total,
                  _ => rightLikeCount / total,
                },
                switch (bias) {
                  Bias.left => leftLikeCount / total,
                  Bias.center => centerLikeCount / total,
                  _ => rightLikeCount / total,
                },
                1.0,
              ],
              colors: [
                getBiasColor(bias).withOpacity(0.2),
                getBiasColor(bias).withOpacity(0.2),
                AppColors.primaryLight,
                AppColors.primaryLight,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? getBiasColor(bias) : AppColors.gray3,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: isSelected ? getBiasColor(bias) : AppColors.gray3,
              ),
              SizedBox(width: MyPaddings.small),
              MyText.reg(switch (bias) {
                Bias.left => leftLikeCount.toString(),
                Bias.right => rightLikeCount.toString(),
                _ => centerLikeCount.toString(),
              }, color: isSelected ? getBiasColor(bias) : AppColors.gray3),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ValueNotifier(userEvaluation),
      builder: (context, listenable) {
        return Ink(
          padding: EdgeInsets.symmetric(horizontal: MyPaddings.large, vertical: MyPaddings.medium),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.gray5,
                blurRadius: 5,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              userEvaluation == null
                  ? MyText.h3('어떤 관점에 동의하시나요?')
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText.h3('내가 동의한 관점 : '),
                  MyText.h3(
                    getBiasName(
                      getBiasFromString(userEvaluation!),
                    ),
                    color: getBiasColor(
                      getBiasFromString(userEvaluation!),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MyPaddings.medium),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                userEvaluation == null
                    ? [
                  if (existLeft) _buildBiasCircle(Bias.left),
                  if (existCenter) _buildBiasCircle(Bias.center),
                  if (existRight) _buildBiasCircle(Bias.right),
                ]
                    : [
                  if (existLeft) _buildBiasRect(Bias.left),
                  if (existCenter) _buildBiasRect(Bias.center),
                  if (existRight) _buildBiasRect(Bias.right),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
