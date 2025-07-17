import 'package:could_be/core/method/bias/bias_enum.dart';
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
    int getWeekOfMonth(DateTime date) {
      // 이번 달 1일
      final firstDayOfMonth = DateTime(date.year, date.month, 1);

      // 1일의 요일 (1: 월요일, 7: 일요일)
      final firstWeekday = firstDayOfMonth.weekday;

      // 날짜와 요일을 고려한 오프셋 일 수
      final offset = date.day + (firstWeekday - 1);

      // 주차 계산 (ceil로 올림 처리)
      return (offset / 7).ceil();
    }

    final DateTime now = DateTime.now();

    final int year = now.year;
    final int? month = period == BiasScorePeriod.yearly ? null : now.month;
    final int? week =
        period == BiasScorePeriod.monthly ? null : getWeekOfMonth(now);
    return await _biasScoreRepository.fetchBiasScoreHistory(year: year, month: month, week: week,);
  }
}
