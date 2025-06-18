import '../../core/base_url.dart';
import '../../domain/entities/issues.dart';
import '../../domain/repositoryInterfaces/issues_interface.dart';
import 'package:dio/dio.dart';

import '../dataSource/issues_dto.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  final Dio dio;
  IssuesRepositoryImpl(this.dio);

  @override
  Future<Issues> fetchDailyIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
      queryParameters: {'type': 'daily', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchHotIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
      queryParameters: {'type': 'hot', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchBlindSpotIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
      queryParameters: {'type': 'blind-spot', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchForYouIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
      queryParameters: {'type': 'for-you', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }
}