import '../../core/base_url.dart';
import '../../domain/entities/issues.dart';
import '../../domain/repositoryInterfaces/issues_interface.dart';
import 'package:dio/dio.dart';

import '../dto/issues_dto.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  final Dio dio;
  IssuesRepositoryImpl(this.dio);

  @override
  Future<Issues> fetchDailyIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Authorization': demoToken,
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
          'Authorization': demoToken,
        },
      ),
      queryParameters: {'type': 'hot', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchBlindSpotLeftIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Authorization': demoToken,
        },
      ),
      queryParameters: {'type': 'blind-spot-left', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchBlindSpotRightIssues() async {
    final response = await dio.get(
      '/issues',
      options: Options(
        headers: {
          'Authorization': demoToken,
        },
      ),
      queryParameters: {'type': 'blind-spot-right', 'limit': 10, 'lastIssueId': ''},
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
          'Authorization': demoToken,
        },
      ),
      queryParameters: {'type': 'for-you', 'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchWatchHistoryIssues() async {
    final response = await dio.get(
      '/user/watch-history',
      options: Options(
        headers: {
          'Authorization' : demoToken
        },
      ),
      queryParameters: {'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchSubscribedIssues() async{
    final response = await dio.get(
      '/issues/subscribed',
      options: Options(
        headers: {
          'Authorization' : demoToken
        },
      ),
      // queryParameters: {'limit': 10, 'lastIssueId': ''},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }
}