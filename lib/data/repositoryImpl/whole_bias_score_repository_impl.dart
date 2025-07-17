import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/data/dto/dasi_score_dto.dart';
import 'package:could_be/data/dto/whole_bias_score_dto.dart';
import 'package:could_be/domain/entities/bias_score_history.dart';
import 'package:could_be/domain/entities/dasi_score.dart';
import 'package:could_be/domain/entities/whole_bias_score.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_bias_score_interface.dart';
import 'package:dio/dio.dart';

import '../dto/bias_score_history_dto.dart';

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
  Future<BiasScoreHistory> fetchBiasScoreHistory({
    required int year, int? month, int? week,
  }) async {
    final response = await dio.get(
      '${ApiVersions.v1}/user/political-score-history',
      queryParameters: {
        'year': year,
        'month': month,
        'week': week,
      },
    );
    final biasScoreHistoryDto = BiasScoreHistoryDto.fromJson(response.data);
    return biasScoreHistoryDto.toDomain();
  }
}