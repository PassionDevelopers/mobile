import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/presentation/my_page/linear_chart_view.dart';
import 'package:could_be/ui/color.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:flutter/material.dart';

import 'my_bias_status_view.dart';

class UserBiasStatusView extends StatelessWidget {
  const UserBiasStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MyPaddings.largeMedium, vertical: MyPaddings.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigTitle(title: '다시 스코어 : 87점',),
            SizedBox(height: MyPaddings.medium,),
            LinearProgressIndicator(
              value: 0.87,
              backgroundColor: AppColors.gray4,
              color: AppColors.primary,
              minHeight: 20,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(height: MyPaddings.medium,),
            Text(' 전반적으로 이슈에 대한 다양한 시각을 이해하고 있습니다. 다만, 특정 이슈에 대한 편향이 존재할 수 있으므로 지속적인 관심과 학습이 필요합니다.',
              style: TextStyle(color: AppColors.gray2),),
            SizedBox(height: MyPaddings.large,),
            BigTitle(title: '나의 성향 : 중도',),
            SizedBox(height: MyPaddings.medium,),
            Text(' 현재 나의 성향은 중도입니다. 중도 성향은 다양한 시각을 이해하고, 극단적인 입장에 치우치지 않는 균형 잡힌 관점을 나타냅니다.',
              style: TextStyle(color: AppColors.gray2),),
            SizedBox(height: MyPaddings.medium,),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 200,width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                child: UserExpRadar(),
              ),
            ),
            SizedBox(height: MyPaddings.large,),
            BigTitle(title: '성향 변화 차트',),
            SizedBox(height: MyPaddings.medium,),
            // Row(
            //   children: [
            //     Icon(Icons.info_outline, color: AppColors.gray3, size: 18,),
            //     MyText.reg(' 나의 성향 변화를 기록합니다.', color: AppColors.gray2),
            //   ],
            // ),
            // SizedBox(height: MyPaddings.medium,),
            Text('  처음 서비스를 시작할 당시 강한 보수 성향을 보였으나 최근 3개월 동안 여러 진보 매체의 보도에 공감하며 중도 보수 성향으로 점차 변화하는 양상입니다.',
                style: TextStyle(color: AppColors.gray2),),
            SizedBox(height: MyPaddings.medium,),
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 250, width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
                child: DailyUserDataChart(),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
