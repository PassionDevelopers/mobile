import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/core/themes/margins_paddings.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../ui/color.dart';

class BiasSwitchButtons extends StatelessWidget {
  const BiasSwitchButtons({super.key, required this.biasNow, required this.onBiasChanged});
  final Bias biasNow;
  final void Function(Bias bias) onBiasChanged;

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup group = AutoSizeGroup();
    return Container(
      height: 35,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.gray5,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        SwitchButton(bias: Bias.left, onTap: onBiasChanged, isSelected: biasNow == Bias.left, pitchSize: group),
        SwitchButton(bias: Bias.center, onTap: onBiasChanged, isSelected: biasNow == Bias.center, pitchSize: group),
        SwitchButton(bias: Bias.right, onTap: onBiasChanged, isSelected: biasNow == Bias.right, pitchSize: group),
      ],),
    );
  }
}


class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key, required this.bias, required this.onTap, required this.isSelected, required this.pitchSize, });
  final Bias bias;
  final bool isSelected;
  final void Function(Bias bias) onTap;
  final AutoSizeGroup pitchSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          onTap(bias);
        },
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

class BiasHexagon extends StatefulWidget {
  const BiasHexagon({super.key, required this.wholeBiasScore, required this.biasNow, required this.onBiasChanged, });
  final WholeBiasScore wholeBiasScore;
  final Bias biasNow;
  final void Function(Bias bias) onBiasChanged;

  @override
  State<BiasHexagon> createState() => _BiasHexagonState();
}

class _BiasHexagonState extends State<BiasHexagon> {

  AutoSizeGroup textGroup = AutoSizeGroup();

  late final List<double> leftBiasScores;
  late final List<double> centerBiasScores;
  late final List<double> rightBiasScores;

  @override
  void initState() {
    super.initState();
    leftBiasScores = [
      widget.wholeBiasScore.politics.left,
      widget.wholeBiasScore.economy.left,
      widget.wholeBiasScore.society.left,
      widget.wholeBiasScore.culture.left,
      widget.wholeBiasScore.international.left,
      widget.wholeBiasScore.technology.left,
    ];
    centerBiasScores = [
      widget.wholeBiasScore.politics.center,
      widget.wholeBiasScore.economy.center,
      widget.wholeBiasScore.society.center,
      widget.wholeBiasScore.culture.center,
      widget.wholeBiasScore.international.center,
      widget.wholeBiasScore.technology.center,
    ];
    rightBiasScores = [
      widget.wholeBiasScore.politics.right,
      widget.wholeBiasScore.economy.right,
      widget.wholeBiasScore.society.right,
      widget.wholeBiasScore.culture.right,
      widget.wholeBiasScore.international.right,
      widget.wholeBiasScore.technology.right,
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        BiasSwitchButtons(biasNow: widget.biasNow, onBiasChanged: widget.onBiasChanged),
        SizedBox(height: MyPaddings.medium),
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
                dataSet(Bias.left, leftBiasScores),
                dataSet(Bias.center, rightBiasScores),
                dataSet(Bias.right, centerBiasScores),
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
                final usedAngle = angle;
                final double ppOffset = 0.07;
                switch (index) {
                  case 0:
                    return RadarChartTitle(
                      text: '정치',
                      angle: usedAngle,
                      positionPercentageOffset: ppOffset,
                    );
                  case 1:
                    return RadarChartTitle(
                      text: '경제',
                      angle: usedAngle,
                      positionPercentageOffset: ppOffset,
                    );
                  case 2:
                    return RadarChartTitle(
                      text: '사회',
                      angle: usedAngle+180,
                      positionPercentageOffset: ppOffset,
                    );
                  case 3:
                    return RadarChartTitle(
                      text: '문화',
                      angle: usedAngle+180,
                      positionPercentageOffset: ppOffset,
                    );
                  case 4:
                    return RadarChartTitle(
                      text: '세계',
                      angle: usedAngle + 180,
                      positionPercentageOffset: ppOffset,
                    );
                  default:
                    return RadarChartTitle(
                      text: '기술',
                      angle: usedAngle,
                      positionPercentageOffset: ppOffset,
                    );
                }
              },
              tickCount: 4,
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

  RadarDataSet dataSet(Bias bias, List<double> values) {
    final isSelected = bias == widget.biasNow;
    final color = getBiasColor(bias);
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