import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_score/whole_bias_score.dart';

import 'bias_score_element.dart';

class BiasScoreHistory{
  final List<BiasScoreElement> history;

  BiasScoreHistory({
    required this.history,
  });

  List<double> get leftBiasScores {
    return history.map((e) => e.leftScoreSum).toList();
  }
  List<double> get rightBiasScores {
    return history.map((e) => e.rightScoreSum).toList();
  }
  List<double> get centerBiasScores {
    return history.map((e) => e.centerScoreSum).toList();
  }
}