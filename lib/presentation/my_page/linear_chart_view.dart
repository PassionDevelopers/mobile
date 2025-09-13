



import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/presentation/my_page/components/my_bias_status_view.dart';
import 'package:could_be/presentation/my_page/main/my_page_view_model.dart';
import 'package:could_be/core/themes/fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../core/method/bias/bias_enum.dart';
import '../../core/themes/color.dart';

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

    Widget loadingChart(){

      final dailyClearData = widget.viewModel.state.biasScoreHistoryLeftScores ?? [1,1,1,1,1,1,1];

      double getHorizontalInterval(){
        double interval = widget.viewModel.state.maxBiasScore - widget.viewModel.state.minBiasScore;
        log('interval: $interval, max: ${widget.viewModel.state.maxBiasScore}, min: ${widget.viewModel.state.minBiasScore}');
        return interval == 0?
          4: ((interval/4)) * 1.0;
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
        List<String> weekDays = ['월', '화', '수', '목', '금', '토', '일'];
        List<String> weeks = ['4주 전', '3주 전', '2주 전', '1주 전', '이번 주'];
        Color textColor = AppColors.primary;
        String t = '';
        int weekDayNum = DateTime.now().weekday;
        int monthNum = DateTime.now().month;
        weekDays = List.generate(7, (index) => weekDays[(index + weekDayNum) % 7]);
        if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.week){
          t = weekDays[groupNum];
        } else if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.month){
          t = weeks[groupNum];
        } else if(widget.viewModel.state.biasScorePeriod == BiasScorePeriod.year){
          t = List.generate(12, (i) => '${(monthNum + i)%12 + 1}월')[groupNum];
        } else {
          t = weekDays[groupNum];
        }
        return MyText.reg(t, color: textColor, group: titleSize, textAlign: TextAlign.center);
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
                              color: AppColors.gray300,
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
                                    child: Center(child: MyText.reg(value>0 ? value.round().toString() : '',
                                        color: AppColors.black))
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
                        minX: 0, maxX: (dailyClearData.length-1)*1.0, maxY: widget.viewModel.state.maxBiasScore,
                        minY: widget.viewModel.state.minBiasScore
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
        isCurved: true,
        // belowBarData: BarAreaData(
        //   show: isSelected,
        //   color: color.withOpacity(isSelected? 0.2 : 0.1),
        // ),
        spots: spots
    );
  }
}