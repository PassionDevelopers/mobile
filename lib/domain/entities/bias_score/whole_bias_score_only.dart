import 'package:could_be/domain/entities/bias_score/bias_score.dart';

class WholeBiasScoreOnly{
  final BiasScore politics;
  final BiasScore economy;
  final BiasScore society;
  final BiasScore culture;
  final BiasScore technology;
  final BiasScore international;

  WholeBiasScoreOnly({
    required this.politics,
    required this.economy,
    required this.society,
    required this.culture,
    required this.technology,
    required this.international,
  });

  double get leftScoreSum {
    return politics.left + economy.left + society.left + international.left + culture.left + technology.left;
  }
  double get centerScoreSum {
    return politics.center + economy.center + society.center + international.center + culture.center + technology.center;
  }
  double get rightScoreSum {
    return politics.right + economy.right + society.right + international.right + culture.right + technology.right;
  }
}