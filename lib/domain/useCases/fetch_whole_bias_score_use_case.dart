import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_bias_score_interface.dart';

class FetchWholeBiasScoreUseCase {
  final WholeBiasScoreRepository _biasScoreRepository;

  FetchWholeBiasScoreUseCase(this._biasScoreRepository);

  Future<DasiScore> fetchDasiScore() async {
    return await _biasScoreRepository.fetchDasiScore();
  }

  Future<WholeBiasScore> fetchWholeBiasScore() async {
    return await _biasScoreRepository.fetchWholeBiasScore();
  }

  Future<BiasScoreHistory> fetchBiasScoreHistory({
    required BiasScorePeriod period,
  }) async {

    final DateTime now = DateTime.now();

    final int year = now.year;
    final int? month = period == BiasScorePeriod.yearly ? null : now.month;
    final int? week =
        period == BiasScorePeriod.monthly ? null : getWeekOfMonth(now);
    return await _biasScoreRepository.fetchBiasScoreHistory(year: year, month: month, week: week,);
  }
}
