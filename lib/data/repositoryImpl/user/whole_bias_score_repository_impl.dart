import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/data/dto/dasi_score_dto.dart';
import 'package:could_be/data/dto/bias_score/whole_bias_score_dto.dart';
import 'package:could_be/domain/entities/bias_score/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/bias_score/whole_bias_score.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_bias_score_interface.dart';
import 'package:dio/dio.dart';

import '../../dto/bias_score/bias_score_history_dto.dart';

class WholeBiasScoreRepositoryImpl extends WholeBiasScoreRepository {
  final Dio dio;

  WholeBiasScoreRepositoryImpl(this.dio);

  @override
  Future<DasiScore> fetchDasiScore() async {
    final response = await dio.get('${ApiVersions.v1}/user/dasi-score');
    final dasiScoreDto = DasiScoreDto.fromJson(response.data);
    return dasiScoreDto.toDomain();
  }



  @override
  Future<WholeBiasScore> fetchWholeBiasScore() async {
    final response = await dio.get('${ApiVersions.v1}/user/political-score');
    final wholeBiasScoreDto = WholeBiasScoreDto.fromJson(response.data);
    return wholeBiasScoreDto.toDomain();
  }

  @override
  void updateWholeBiasScore(WholeBiasScore wholeBiasScore) {
    final updatedDto = wholeBiasScore.toDto();
    final response = dio.post(
      '${ApiVersions.v1}/user/onboarding',
      data: {
        'score': updatedDto.toJson(),
      }
    );
  }

  @override
  Future<BiasScoreHistory> fetchBiasScoreHistory({
    required BiasScorePeriod period,
  }) async {

    final response = await dio.get(
      '${ApiVersions.v1}/user/political-score-history',
      queryParameters: {
        'recent': period.name,
        // 'year': year,
        // if (month != null) 'month': month,
        // if (week != null) 'week': week,
      },
    );
    final biasScoreHistoryDto = BiasScoreHistoryDto.fromJson(response.data);
    return biasScoreHistoryDto.toDomain();
  }
}