import 'package:could_be/domain/entities/bias_score.dart';

class WholeBiasScore {
  final BiasScore politics;
  final BiasScore economy;
  final BiasScore society;
  final BiasScore culture;
  final BiasScore technology;
  final BiasScore international;
  final DateTime createdAt;
  final String userId;

  const WholeBiasScore({
    required this.politics,
    required this.economy,
    required this.society,
    required this.culture,
    required this.technology,
    required this.international,
    required this.createdAt,
    required this.userId,
  });

  double getLeftTotal() {
    return politics.left + economy.left + society.left + culture.left + technology.left + international.left;
  }
  double getCenterTotal() {
    return politics.center + economy.center + society.center + culture.center + technology.center + international.center;
  }
  double getRightTotal() {
    return politics.right + economy.right + society.right + culture.right + technology.right + international.right;
  }
}