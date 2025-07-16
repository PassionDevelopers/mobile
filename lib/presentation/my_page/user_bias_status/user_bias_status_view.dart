import 'package:could_be/core/components/app_bar/app_bar.dart';
import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/components/layouts/scaffold_layout.dart';
import 'package:could_be/core/components/title/big_title.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
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
    return RegScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RegAppBar(title: '나의 성향 분석', iconData: Icons.bar_chart_outlined),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MyPaddings.largeMedium,
                vertical: MyPaddings.large,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modern Score Card with Gradient Background
                  _buildScoreCard(),
                  SizedBox(height: MyPaddings.extraLarge),

                  // Modern Bias Analysis Card
                  _buildBiasAnalysisCard(Bias.center),
                  SizedBox(height: MyPaddings.extraLarge),

                  // Modern Trend Chart Card
                  _buildTrendChartCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      padding: EdgeInsets.all(MyPaddings.extraLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.analytics_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: MyPaddings.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '다시 스코어',
                      style: MyFontStyle.h2.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '87점',
                      style: MyFontStyle.accent.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MyPaddings.extraLarge),

          // Modern Progress Bar with Glass Effect
          Container(
            height: 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white.withOpacity(0.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: 0.87,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
          SizedBox(height: MyPaddings.extraLarge),

          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              '전반적으로 이슈에 대한 다양한 시각을 이해하고 있습니다. 다만, 특정 이슈에 대한 편향이 존재할 수 있으므로 지속적인 관심과 학습이 필요합니다.',
              style: MyFontStyle.reg.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiasAnalysisCard(Bias bias) {
    return Container(
      padding: EdgeInsets.all(MyPaddings.extraLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: getBiasColor(bias),
        boxShadow: [
          BoxShadow(
            color: getBiasColor(bias).withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.balance_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: MyPaddings.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 성향',
                      style: MyFontStyle.h2.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '중도',
                      style: MyFontStyle.h1.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MyPaddings.extraLarge),

          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              '현재 나의 성향은 중도입니다. 중도 성향은 다양한 시각을 이해하고, 극단적인 입장에 치우치지 않는 균형 잡힌 관점을 나타냅니다.',
              style: MyFontStyle.reg.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          SizedBox(height: MyPaddings.extraLarge),

          // Modern Chart Container
          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.15),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: UserExpRadar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendChartCard() {
    return Container(
      padding: EdgeInsets.all(MyPaddings.extraLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.gray2, AppColors.gray2],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray2.withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.trending_up_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: MyPaddings.large),
              Expanded(
                child: Text(
                  '성향 변화 차트',
                  style: MyFontStyle.h1.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: MyPaddings.extraLarge),

          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.1),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Text(
              '처음 서비스를 시작할 당시 강한 보수 성향을 보였으나 최근 3개월 동안 여러 진보 언론의 보도에 공감하며 중도 보수 성향으로 점차 변화하는 양상입니다.',
              style: MyFontStyle.reg.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          SizedBox(height: MyPaddings.extraLarge),

          // Modern Chart Container
          Container(
            padding: EdgeInsets.all(MyPaddings.large),
            height: 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.15),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: DailyUserDataChart(),
          ),
        ],
      ),
    );
  }
}
