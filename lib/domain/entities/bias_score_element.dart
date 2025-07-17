import 'package:could_be/domain/entities/period_info.dart';
import 'package:could_be/domain/entities/whole_bias_score_only.dart';

class BiasScoreElement {
  final PeriodInfo period;
  final WholeBiasScoreOnly? score;

  BiasScoreElement({
    required this.period,
    required this.score,
  });

  double get leftScoreSum {
    if (score == null) return 0.0;
    return score!.leftScoreSum;
  }

  double get centerScoreSum {
    if (score == null) return 0.0;
    return score!.centerScoreSum;
  }

  double get rightScoreSum {
    if (score == null) return 0.0;
    return score!.rightScoreSum;
  }

}