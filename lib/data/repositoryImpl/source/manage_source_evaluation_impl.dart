import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/repositoryInterfaces/source/mange_source_evalutaion_interface.dart';
import 'package:dio/dio.dart';

class ManageSourceEvaluationRepositoryImpl extends ManageSourceEvaluationRepository {
  final Dio dio;
  ManageSourceEvaluationRepositoryImpl(this.dio);

  @override
  Future<void> evaluateSource({
    required String sourceId,
    required String perspective,
  }) async {
    dio.post(
      '${ApiVersions.v1}/media/$sourceId/evaluate',
      data: {
        'perspective': perspective,
      },
    );
  }
}