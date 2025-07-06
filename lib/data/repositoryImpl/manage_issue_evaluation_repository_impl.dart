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
      '/user/evaluate/$issueId',
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
      '/user/evaluate/$issueId',
    );
  }

  @override
  Future<void> updateIssueEvaluation({
    required String issueId,
    required String perspective,
  }) async {
    final response = await dio.put(
      '/user/evaluate/$issueId',
      data: {
        'perspective': perspective,
      },
    );
  }
}