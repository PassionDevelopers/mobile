import 'package:could_be/data/dto/bias_score/whole_bias_score_dto.dart';
import 'package:could_be/domain/entities/bias_score/bias_score.dart';

import '../../../data/dto/bias_score/bias_score_dto.dart';

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

  WholeBiasScoreDto toDto() {
    return WholeBiasScoreDto(
      politics: politics.toDto(),
      economy: economy.toDto(),
      society: society.toDto(),
      culture: culture.toDto(),
      technology: technology.toDto(),
      international: international.toDto(),
      createdAt: createdAt,
      userId: userId,
    );
  }
}