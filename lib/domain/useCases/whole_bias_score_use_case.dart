import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/core/method/date_time_parsing.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/domain/entities/bias_score/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/bias_score/whole_bias_score.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_bias_score_interface.dart';

class WholeBiasScoreUseCase {
  final WholeBiasScoreRepository _biasScoreRepository;

  WholeBiasScoreUseCase(this._biasScoreRepository);

  Future<DasiScore> fetchDasiScore() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchDasiScore,
    );
    return await _biasScoreRepository.fetchDasiScore();
  }

  Future<WholeBiasScore> fetchWholeBiasScore() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchWholeBiasScore,
    );
    return await _biasScoreRepository.fetchWholeBiasScore();
  }

  void updateWholeBiasScore(WholeBiasScore wholeBiasScore) {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.updateWholeBiasScore,
    );
    _biasScoreRepository.updateWholeBiasScore(wholeBiasScore);
  }

  Future<BiasScoreHistory> fetchBiasScoreHistory({
    required BiasScorePeriod period,
  }) async {

    final DateTime now = DateTime.now();

    // final int year = now.year;
    // final int? month = period == BiasScorePeriod.year ? null : now.month;
    // final int? week =
    //     period == BiasScorePeriod.monthly ? null : getWeekOfMonth(now);
    
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.fetchBiasScoreHistory,
      parameters: {
        'recent' : period.toString()
        // 'period': period.toString(),
        // 'year': year.toString(),
        // if (month != null) 'month': month.toString(),
        // if (week != null) 'week': week.toString(),
      },
    );
    
    return await _biasScoreRepository.fetchBiasScoreHistory(period: period);
  }
}
