import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/components/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/ui/fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/many_use.dart';
import '../../../ui/color.dart';
import '../linear_chart_view.dart';

class MyBiasStatusView extends StatelessWidget {
  const MyBiasStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10,),
        autoSizeText('나의 편향성 분석', fontSize: 24, fontWeight: FontWeight.bold,),
        const SizedBox(height: 20,),
        autoSizeText('나의 관심 이슈', fontSize: 24, ),
        const SizedBox(height: 10,),

        const SizedBox(height: 20,),
        autoSizeText('주간 성향 기록', fontSize: 24, ),
        const SizedBox(height: 10,),
        Center(
          child: Container(height: 250,width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: DailyUserDataChart(),
          ),
        ),
      ],
    );
  }
}

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key, required this.bias, required this.onTap, required this.isSelected, required this.pitchSize, });
  final Bias bias;
  final VoidCallback onTap;
  final bool isSelected;
  final AutoSizeGroup pitchSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isSelected ? getBiasColor(bias) : Colors.transparent,
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
                    color: isSelected ? Colors.white : getBiasColor(bias),
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(getBiasName(bias)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class UserExpRadar extends StatefulWidget {
  const UserExpRadar({super.key});

  @override
  State<UserExpRadar> createState() => _UserExpRadarState();
}

class _UserExpRadarState extends State<UserExpRadar> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;

  AutoSizeGroup textGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    int abIndex = 0;
    int reIndex = 1;
    AutoSizeGroup group = AutoSizeGroup();

    return Column(
      children: [
        Container(
          height: 35,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.gray5,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(children: [
              SwitchButton(bias: Bias.left, onTap: (){}, isSelected: true, pitchSize: group),
              SwitchButton(bias: Bias.center, onTap: (){}, isSelected: false, pitchSize: group),
              SwitchButton(bias: Bias.right, onTap: (){}, isSelected: false, pitchSize: group),
          ],),
        ),
        SizedBox(height: 10),
        Expanded(
          child: RadarChart(
            RadarChartData(
              // radarTouchData:
              // RadarTouchData(
              //   touchCallback: (FlTouchEvent event, response) {
              //     if (!event.isInterestedForInteractions) {
              //       setState(() {
              //         selectedDataSetIndex = -1;
              //       });
              //       return;
              //     }
              //     setState(() {
              //       selectedDataSetIndex =
              //           response?.touchedSpot?.touchedDataSetIndex ?? -1;
              //     });
              //   },
              // ),
              dataSets: [
                gridDataSet([0,0,0,0,0,0]),
                gridDataSet(List<double>.generate(6, (int i)=> 100.0)),
                dataSet(abIndex, AppColors.left, '', [100, 20, 30, 40, 50, 60]),
                dataSet(abIndex, AppColors.right, '', [20, 40, 60, 80, 100, 90]),
                // dataSet(reIndex, AbpColor.nb1, GaWords.relative2[store5.language], (widget.friendsData ?? store1.exps).getRelativeExps()),
              ],
              radarBackgroundColor: Colors.transparent,
              radarShape: RadarShape.polygon,
              borderData: FlBorderData(show: false),
              radarBorderData: const BorderSide(color: Colors.transparent),
              titlePositionPercentageOffset: 0.2,
              titleTextStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              getTitle: (index, angle) {
                final usedAngle = angle + angleValue;
                switch (index) {
                  case 0:
                    return RadarChartTitle(
                      text: '정치',
                      angle: usedAngle,);
                  case 1:
                    return RadarChartTitle(
                      text: '경제',
                      angle: usedAngle,);
                  case 2:
                    return RadarChartTitle(
                      text: '사회',
                      angle: usedAngle+180,);
                  case 3:
                    return RadarChartTitle(
                      text: '문화',
                      angle: usedAngle+180,);
                  case 4:
                    return RadarChartTitle(
                      text: '세계',
                      angle: usedAngle + 180,);
                  default:
                    return RadarChartTitle(
                      text: '기타',
                      angle: usedAngle,);

                }
              },
              tickCount: 5,
              ticksTextStyle: const TextStyle(color: Colors.transparent, fontSize: 0),
              tickBorderData: BorderSide(color: AppColors.gray4, width: 0.5),
              gridBorderData: BorderSide(color: AppColors.gray4, width: 0.5),
            ),
            swapAnimationDuration: const Duration(milliseconds: 400),
          ),
        ),
      ],
    );
  }

  RadarDataSet dataSet(int index, Color color, String title,
      List<int> values) {
    final isSelected = index == selectedDataSetIndex ? true : false;
    return RadarDataSet(
      fillColor: isSelected ? color.withOpacity(0.25) : color.withOpacity(0.15),
      borderColor: isSelected ? color : color.withOpacity(0.8),
      entryRadius: isSelected ? 4 : 3,
      dataEntries: values.map((e) => RadarEntry(value: e*1.0)).toList(),
      borderWidth: isSelected ? 3 : 2.5,
    );
  }

  RadarDataSet gridDataSet(List<double> values) {
    return RadarDataSet(
      fillColor: Colors.transparent,
      borderColor: AppColors.gray4,
      entryRadius: 0,
      dataEntries: values.map((e) => RadarEntry(value: e)).toList(),
      borderWidth: 0.5,
    );
  }
}