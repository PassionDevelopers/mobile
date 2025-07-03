import 'package:could_be/core/components/cards/text_card.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bias/bias_enum.dart';
import '../../../core/method/bias/bias_method.dart';
import '../../../core/themes/margins_paddings.dart';

class IssueDetailBiasComparison extends StatelessWidget {
  const IssueDetailBiasComparison({super.key, required this.biasComparison, required this.onBiasSelected});
  final String biasComparison;
  final void Function(Bias bias) onBiasSelected;

  _buildBiasCircle(Bias bias){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MyPaddings.small, vertical: MyPaddings.small),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          onBiasSelected(bias);
        },
        child: Ink(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: getBiasColor(bias)),
          ),
          child: Center(
            child: Icon(Icons.check, color: getBiasColor(bias)),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BigTitle(title: '언론 성향별 차이점'),
        SizedBox(height: MyPaddings.medium),
        Expanded(child: TextCard(color: AppColors.primary, child:  MyText.article(biasComparison))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MyPaddings.large),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: MyPaddings.small),
                child: MyText.h3('어떤 관점에 동의하시나요?'),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBiasCircle(Bias.left),
                  _buildBiasCircle(Bias.center),
                  _buildBiasCircle(Bias.right),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: MyPaddings.medium),
      ],
    );
  }
}
