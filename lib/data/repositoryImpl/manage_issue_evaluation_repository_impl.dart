import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_evaluation_interface.dart';
import 'package:dio/dio.dart';

class ManageIssueEvaluationRepositoryImpl extends ManageIssueEvaluationRepository{
  final Dio dio;
  ManageIssueEvaluationRepositoryImpl(this.dio);

  @override
  Future<void> evaluateIssue({
    required String issueId,
    required String perspective,
  }) async {
    final response = await dio.post(
      '${ApiVersions.v1}/user/evaluate/$issueId',
      data: {
        'perspective': perspective,
      },
    );
  }

  @override
  Future<void> deleteIssueEvaluation({
    required String issueId,
  }) async {
    final response = await dio.delete(
      '${ApiVersions.v1}/user/evaluate/$issueId',
    );
  }

  @override
  Future<void> updateIssueEvaluation({
    required String issueId,
    required String perspective,
  }) async {
    final response = await dio.put(
      '${ApiVersions.v1}/user/evaluate/$issueId',
      data: {
        'perspective': perspective,
      },
    );
  }
}