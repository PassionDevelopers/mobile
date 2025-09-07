import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';

class BiasQuizResultVo{
  final Bias bias;
  final String summary;
  final String dominantCategory;
  final WholeBiasScore wholeBiasScore;

  BiasQuizResultVo({
    required this.bias,
    required this.summary,
    required this.dominantCategory,
    required this.wholeBiasScore,
  });
}