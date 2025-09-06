import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';

abstract class WholeBiasScoreRepository{

  Future<DasiScore> fetchDasiScore();

  Future<WholeBiasScore> fetchWholeBiasScore();

  Future<BiasScoreHistory> fetchBiasScoreHistory({required BiasScorePeriod period});

  void updateWholeBiasScore(WholeBiasScore wholeBiasScore);

}