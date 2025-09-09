import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/domain/entities/period_info.dart';
import 'package:could_be/domain/entities/bias_score/whole_bias_score_only.dart';

class BiasScoreElement {
  final PeriodInfo period;
  final WholeBiasScoreOnly? score;

  BiasScoreElement({
    required this.period,
    required this.score,
  });

  double checkFuturePast(double scoreSum) {
    final DateTime now = DateTime.now();
    return scoreSum;

    //최근으로 바꾸기 전
    if(period.weekday == null){
      // 연간 데이터
      if(period.week == null){
        // 미래면
        if(period.month! > now.month ){
          return 0;
          // 과거 또는 현재면
        }else{
          return scoreSum;
        }
        //월간 데이터
      }else{
        final int week = getWeekOfMonth(now);
        // 미래면
        if(period.week! > week) {
          return 0;
          // 과거 또는 현재면
        }else{
          return scoreSum;
        }
      }
      // 주간 데이터
    }else{
      if(period.weekday! > now.weekday) {
        return 0; // 미래면
      } else{
        return scoreSum; // 과거 또는 현재면
      }
    }
  }

  double get leftScoreSum {
    if (score == null){
      return 0;
    }else{
      return checkFuturePast(score!.leftScoreSum);
    }
  }

  double get centerScoreSum {
    if (score == null){
      return 0;
    }else {
      return checkFuturePast(score!.centerScoreSum);
    }
  }

  double get rightScoreSum {
    if (score == null){
      return 0;
    }else {
      return checkFuturePast(score!.rightScoreSum);
    }
  }

}