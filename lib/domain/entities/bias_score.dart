import 'package:could_be/data/dto/bias_score_dto.dart';

class BiasScore{
  final double left;
  final double center;
  final double right;

  BiasScore({
    required this.left,
    required this.center,
    required this.right,
  });

  BiasScoreDto toDto() {
    return BiasScoreDto(left, center, right);
  }
}