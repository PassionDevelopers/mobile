

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/presentation/my_page/components/my_bias_status_view.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/method/bias/bias_enum.dart';
import '../../core/many_use.dart';
import '../../ui/color.dart';

class DailyUserDataChart extends StatefulWidget {
  const DailyUserDataChart({super.key, required this.viewModel});
  final MyPageViewModel viewModel;
  @override
  State<DailyUserDataChart> createState() => _DailyUserDataChartState();
}

class _DailyUserDataChartState extends State<DailyUserDataChart> {

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup titleSize = AutoSizeGroup();
    double maxTotal = 0;

    loadingChart(){

      final dailyClearData = widget.viewModel.state.biasScoreHistoryLeftScores ?? [1,1,1,1,1,1,1];

      double getHorizontalInterval(){
        // return widget.viewModel.state.maxBiasScore == 0? 5: ((maxTotal/3).ceil()) * 1.0;
        return 50;
      }
      LineTouchData lineTouchData()=>LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: const EdgeInsets.all(5),
          fitInsideHorizontally : true,
          fitInsideVertically: true,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

      Widget title(int groupNum){
        List<String> weekDays = ['일', '월', '화', '수', '목', '금', '토'];
        List<String> weeks = ['1주차', '2주차', '3주차', '4주차', '5주차', '6주차', '7주차'];
        List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        Color textColor = AppColors.primary;
        String t = '';
        if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.weekly){
          t = weekDays[groupNum];
        } else if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.monthly){
          t = weeks[groupNum];
        } else if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.yearly){
          t = months[groupNum];
        } else {
          t = weekDays[groupNum];
        }
        return autoSizeText(t, color: textColor, group: titleSize, textAlign: TextAlign.center);
      }

      return Column(
        children: [
          BiasSwitchButtons(biasNow: widget.viewModel.state.biasNow, onBiasChanged: widget.viewModel.changeBiasNow),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final leftHeight = constraints.maxHeight*0.9;
                final bottomWidth = constraints.maxWidth*0.85;
                return Padding(
                    padding: EdgeInsets.only(top: leftHeight/10),
                    child: LineChart(
                      LineChartData(
                        lineTouchData: lineTouchData(),
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: getHorizontalInterval(),
                          getDrawingHorizontalLine: (double value) {
                            return FlLine(
                              color: AppColors.gray5,
                              strokeWidth: 1,
                              dashArray: [1,0],
                            );
                          },
                          drawVerticalLine: false,
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: leftHeight/5,
                                  interval: 1,
                                  getTitlesWidget: (double value, TitleMeta meta) {
                                    return Container(
                                        width: bottomWidth/(dailyClearData.length),
                                        padding: const EdgeInsets.all(1.0),
                                        child: title(value.round())
                                    );
                                  }
                              )
                          ),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,
                              reservedSize: bottomWidth/(dailyClearData.length)/2,
                              getTitlesWidget: (value, meta)=>const SizedBox()),),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false),),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return Container(
                                    width: bottomWidth/(dailyClearData.length),
                                    padding: const EdgeInsets.all(1.0),
                                    child: Center(child: autoSizeText(value>0 ? value.round().toString() : '', color: AppColors.white))
                                );
                              },
                              showTitles: true,
                              interval: getHorizontalInterval(),
                              reservedSize: bottomWidth/(dailyClearData.length)/2,
                            ),
                          ),
                        ),
                        borderData: borderData,
                        lineBarsData: [
                          chartBarData(Bias.left),
                          chartBarData(Bias.center),
                          chartBarData(Bias.right),
                        ],
                        minX: 0, maxX: (dailyClearData.length-1)*1.0, maxY: widget.viewModel.state.maxBiasScore*1.0, minY: 300,
                      ),
                      duration: const Duration(milliseconds: 250),
                    )
                );
              },
            ),
          ),
        ],
      ) ;
    }
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _){
        return loadingChart();
      },
    );
  }

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(color:AppColors.white.withOpacity(0.5)),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: BorderSide(color: AppColors.white.withOpacity(0.5)),
    ),
  );

  LineChartBarData chartBarData(Bias bias) {
    List<double> dailyClearData = switch(bias) {
      Bias.left || Bias.leftCenter => widget.viewModel.state.biasScoreHistoryLeftScores,
      Bias.center => widget.viewModel.state.biasScoreHistoryCenterScores,
      Bias.right || Bias.rightCenter => widget.viewModel.state.biasScoreHistoryRightScores,
    } ?? [];
    List<FlSpot> spots = [];
    Color color = getBiasColor(bias);
    for(int i = 0; i<dailyClearData.length; i++){
      if(dailyClearData[i] == 0) continue;
      spots.add(FlSpot(i*1.0, dailyClearData[i]));
    }
    final bool isSelected = widget.viewModel.state.biasNow == bias;
    return LineChartBarData(
        color: color.withOpacity(isSelected? 0.8 : 0.2),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: isSelected,
          color: color.withOpacity(isSelected? 0.2 : 0.1),
        ),
        spots: spots
    );
  }
}