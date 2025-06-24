import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:could_be/presentation/my_page/user_bias_status/my_bias_status_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/components/bias/bias_enum.dart';
import '../../core/many_use.dart';
import '../../ui/color.dart';

class DailyUserDataChart extends StatefulWidget {
  const DailyUserDataChart({super.key});

  @override
  State<DailyUserDataChart> createState() => _DailyUserDataChartState();
}

class _DailyUserDataChartState extends State<DailyUserDataChart> {
  // late bool isAbsoluteNow;
  bool isRhythmNow = false;
  int dateRange = 0;
  final DateTime today = DateTime.now();
  final int toWeekDay = DateTime.now().weekday;
  final int toMonth = DateTime.now().month;
  final int toYear = DateTime.now().year;
  int targetYear = DateTime.now().year;

  List<BarChartGroupData> getData(double barsWidth, double barsSpace, Map<String, DailyUserData> dailyClearData){
    BorderRadius borderRadius = BorderRadius.circular(3);
    BarChartGroupData barChartGroupData(int groupNum, DailyUserData data, bool showTip){
      return BarChartGroupData(
        showingTooltipIndicators: showTip? [0] : [],
        x: groupNum,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: data.absolute.getSum()*1.0,
            borderRadius:borderRadius,
            width: barsWidth,
          ),
          BarChartRodData(
            toY: data.relative.getSum()*1.0,
            borderRadius:borderRadius,
            width: barsWidth,
          )
        ],
      );
    }

    List<BarChartGroupData> barDatas = [for(int i = 0; i<dailyClearData.length; i++) barChartGroupData(i, dailyClearData.values.toList()[i],
        (dateRange == 0 && i+1 <= toWeekDay) || dateRange == 1 || ( (dateRange == 2 && i+1 <= toMonth && targetYear == toYear)  || (dateRange == 2 && targetYear < toYear) ) )];

    return barDatas;
  }

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup titleSize = AutoSizeGroup();
    AutoSizeGroup group = AutoSizeGroup();
    int maxTotal = 0;
    Future<Map<String, DailyUserData>> getDailyData()async{
      Map<String, DailyUserData> dailyClearData = {};
      for(int i = 0; i<7; i++){
        DateTime date = today.subtract(Duration(days: i));
        String key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        dailyClearData[key] = DailyUserData(
          absolute: DailyCateExp(
            interval: Random().nextInt(30),
            scale:Random().nextInt(30),
            chord: Random().nextInt(30),
            melody: Random().nextInt(30),
            chordProg: Random().nextInt(30),
          ),
          relative: DailyCateExp(
            interval: Random().nextInt(30),
            scale: Random().nextInt(30),
            chord: Random().nextInt(30),
            melody: Random().nextInt(30),
            chordProg: Random().nextInt(30),
          ),
          rhythm: Random().nextInt(30),
        );
      }
      return dailyClearData;
      // if(dateRange == 0){
      //   return store1.getOneWeekData(friendsData: widget.friendsData);
      // }else if(dateRange == 1){
      //   return store1.get4WeeksData(friendsData: widget.friendsData);
      // }else{
      //   return store1.getYearData(targetYear, friendsData: widget.friendsData);
      // }
    }

    loadingChart(Map<String, DailyUserData> dailyClearData){
      double getHorizontalInterval(){
        List<int> totals = [ for(DailyUserData data in dailyClearData.values) data.relative.getSum()] +
            [ for(DailyUserData data in dailyClearData.values) data.absolute.getSum()] +
            [ for(DailyUserData data in dailyClearData.values) data.rhythm];
        maxTotal = totals.reduce(max);
        return maxTotal == 0? 5: ((maxTotal/3).ceil()) * 1.0;
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
        List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        List<String> weeks = ['3w ago', '2w ago', 'last week', 'this week'];
        List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        Color textColor = AbpColor.n4;
        if(dateRange == 0 && toWeekDay == groupNum + 1){
          textColor = AppColors.left;
        }else if(dateRange == 1 && groupNum == 3){
          textColor = AppColors.left;
        }else if(dateRange == 2 && toMonth == groupNum +1 && targetYear == toYear){
          textColor = AppColors.left;
        }
        String t = dateRange == 0? weekDays[groupNum] : dateRange == 1? weeks[groupNum] : months[groupNum];

        return autoSizeText(t, color: textColor, group: titleSize, textAlign: TextAlign.center);
      }

      return Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(children: [
              SwitchButton(bias: Bias.left, onTap: (){}, isSelected: true, pitchSize: group),
              SwitchButton(bias: Bias.center, onTap: (){}, isSelected: false, pitchSize: group),
              SwitchButton(bias: Bias.right, onTap: (){}, isSelected: false, pitchSize: group),
            ],),
          ),
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
                              color: AbpColor.n8.withOpacity(0.5),
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
                                    child: Center(child: autoSizeText(value>0 ? value.round().toString() : '', color: AbpColor.n4))
                                );
                              },
                              showTitles: true,
                              interval: getHorizontalInterval(),
                              reservedSize: bottomWidth/(dailyClearData.length)/2,
                            ),
                          ),
                        ),
                        borderData: borderData,
                        lineBarsData:
                        // isRhythmNow? [
                        //   chartBarData(dailyClearData, isAbsolute: false, isRhythm: false),
                        //   chartBarData(dailyClearData, isAbsolute: true, isRhythm: false),
                        //   chartBarData(dailyClearData, isAbsolute: false, isRhythm: true),
                        // ] :
                        // isAbsoluteNow ?
                        // [
                        //   chartBarData(dailyClearData, isAbsolute: false, isRhythm: true),
                        //   chartBarData(dailyClearData, isAbsolute: false, isRhythm: false),
                        //   chartBarData(dailyClearData, isAbsolute: true, isRhythm: false),
                        // ] :
                        [
                          chartBarData(dailyClearData, isAbsolute: false, isRhythm: true),
                          chartBarData(dailyClearData, isAbsolute: true, isRhythm: false),
                          chartBarData(dailyClearData, isAbsolute: false, isRhythm: false),
                        ],
                        minX: 0, maxX: (dailyClearData.length-1)*1.0, maxY: maxTotal*1.0, minY: 0,
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

    return FutureBuilder<Map<String, DailyUserData>>(
      future: getDailyData(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, DailyUserData>> snapshot){
        if (snapshot.hasError) {
          snapshot.printError();
          return Center(child: Text('Error 10'),);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return loadingChart(snapshot.data!);
        }
        return const Center(child: SizedBox(width:20, child: CircularProgressIndicator()));
      },
    );
  }

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(color:AbpColor.n8.withOpacity(0.5)),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: BorderSide(color: AbpColor.n8.withOpacity(0.5)),
    ),
  );

  LineChartBarData chartBarData(Map<String, DailyUserData> dailyClearData, {required bool isAbsolute, required bool isRhythm}){
    List<FlSpot> spots = [];
    for(int i = 0; i<dailyClearData.length; i++){
      spots.add(FlSpot(i*1.0, (isRhythm? dailyClearData.values.toList()[i].rhythm
          : isAbsolute? dailyClearData.values.toList()[i].absolute.getSum() : dailyClearData.values.toList()[i].relative.getSum())*1.0));
    }
    return LineChartBarData(
        color: isRhythm? AppColors.center.withOpacity(1) : isAbsolute? AppColors.left.withOpacity(true ? 1: 0.5)
            : AppColors.right.withOpacity(true?0.5 : 1),
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: true,
          color: isRhythm? AbpColor.d5.withOpacity(0.2) : isAbsolute? AppColors.left.withOpacity(0.2) : AppColors.right.withOpacity(0.2),
        ),
        spots: spots
    );
  }
}




class DailyUserData{
  DailyCateExp absolute;
  DailyCateExp relative;
  int rhythm;

  int getIntervalSum() => absolute.interval + relative.interval;
  int getScaleSum() => absolute.scale + relative.scale;
  int getChordSum() => absolute.chord + relative.chord;
  int getMelodySum() => absolute.melody + relative.melody;
  int getChordProgSum() => absolute.chordProg + relative.chordProg;

  int getSum(){
    return rhythm + absolute.getSum() + relative.getSum();
  }

  bool isEmpty(){
    return getSum() == 0;
  }

  // int getMaxExp(){
  //   return [absolute.getMaxExp(), relative.getMaxExp()].max;
  // }

  List<int> getAbsoluteExps(){
    return [absolute.interval, rhythm, absolute.scale, absolute.chord, absolute.melody, absolute.chordProg];
  }

  List<int> getRelativeExps(){
    return [relative.interval, rhythm, relative.scale, relative.chord, relative.melody, relative.chordProg];
  }

  DailyUserData({required this.absolute, required this.relative, required this.rhythm});

  // DailyUserData addExp({required bool isAbsolute, required CategoryName categoryName, required int exp}){
  //   if(categoryName == CategoryName.rhythm){
  //     rhythm += exp;
  //   }else if(isAbsolute) {
  //     absolute = absolute.addExp(categoryName: categoryName, exp: exp);
  //   }else{
  //     relative = relative.addExp(categoryName: categoryName, exp: exp);
  //   }
  //   return this;
  // }

  static DailyUserData getZero(){
    return DailyUserData(absolute: DailyCateExp.getZero(), relative: DailyCateExp.getZero(), rhythm: 0);
  }

  DailyUserData.fromMap(Map<String, dynamic> dailyUserDataMap)
      :absolute = DailyCateExp.fromMap(dailyUserDataMap['absolute']),
        relative = DailyCateExp.fromMap(dailyUserDataMap['relative']),
        rhythm = dailyUserDataMap['rhythm'];

  static Map<String, dynamic> toMap(DailyUserData dailyUserData){
    return {
      'absolute' : DailyCateExp.toMap(dailyUserData.absolute),
      'relative' : DailyCateExp.toMap(dailyUserData.relative),
      'rhythm' : dailyUserData.rhythm
    };
  }
}

class DailyCateExp{
  int interval;
  int scale;
  int chord;
  int melody;
  int chordProg;

  // int getMaxExp(){
  //   return [interval, scale, chord, melody, chordProg].max;
  // }

  // DailyCateExp addExp({required CategoryName categoryName, required int exp}){
  //   switch(categoryName){
  //     case CategoryName.interval: interval += exp;
  //     case CategoryName.scale: scale += exp;
  //     case CategoryName.chord: chord += exp;
  //     case CategoryName.melody: melody += exp;
  //     case CategoryName.chordProg: chordProg += exp;
  //     case CategoryName.rhythm: break;
  //   }
  //   return this;
  // }

  int getSum(){
    return interval + scale + chord + melody + chordProg;
  }

  DailyCateExp addTwo(DailyCateExp other){
    return DailyCateExp(interval: interval + other.interval, scale: scale + other.scale,
        chord: chord + other.chord, melody: melody + other.melody, chordProg: chordProg + other.chordProg);
  }

  static DailyCateExp getZero(){
    return DailyCateExp(interval: 0, scale: 0, chord: 0, melody: 0, chordProg: 0);
  }

  DailyCateExp({required this.interval, required this.scale, required this.chord, required this.melody, required this.chordProg});

  DailyCateExp.fromMap(Map<String, dynamic> dailyCateExp)
      : interval = dailyCateExp['interval'],
        scale = dailyCateExp['scale'],
        chord = dailyCateExp['chord'],
        melody = dailyCateExp['melody'],
        chordProg = dailyCateExp['chordProg'];

  static Map<String, dynamic> toMap(DailyCateExp dailyCateExp){
    return {
      'interval' : dailyCateExp.interval,
      'scale' : dailyCateExp.scale,
      'chord' : dailyCateExp.chord,
      'melody' : dailyCateExp.melody,
      'chordProg' : dailyCateExp.chordProg,
    };
  }
}