import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/entities/issue/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/issues_interface.dart';
import '../../../domain/entities/issue/issues.dart';
import 'package:dio/dio.dart';
import '../../dto/issue/issues_dto.dart';

class IssuesRepositoryImpl implements IssuesRepository {
  final Dio dio;
  IssuesRepositoryImpl(this.dio);

  @override
  Future<Issues> searchIssues(String query) async {
    log('Search Issues Query: $query');
    final response = await dio.get(
      '${ApiVersions.v1}/issues/search',
      queryParameters: {'q': query},
    );
    log('Search Issues Response: ${response.data}');
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchQueryParamIssues(IssueQueryParam issueQueryParam, {String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues',
      queryParameters: {'type': issueQueryParam.queryParam, 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchDailyIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues',
      queryParameters: {'type': 'daily', 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchHotIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues',

      queryParameters: {'type': 'hot', 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchBlindSpotLeftIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues',

      queryParameters: {'type': 'blind-spot-left', 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchBlindSpotRightIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues',

      queryParameters: {'type': 'blind-spot-right', 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchForYouIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '/issues',
      queryParameters: {'type': 'for-you', 'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchWatchHistoryIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '/user/watch-history',
      queryParameters: {'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchSubscribedIssues({String? lastIssueId}) async{
    final response = await dio.get(
      '/issues/subscribed',
      queryParameters: {'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchIssuesByTopicId(String topicId, {String? lastIssueId}) async {
    final response = await dio.get(
      '/topics/$topicId/issues',
      queryParameters: {'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchSubscribedTopicIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '/topics/subscribed/issues',
      queryParameters: {'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }

  @override
  Future<Issues> fetchIssuesEvaluated({String? lastIssueId}) async {
    final response = await dio.get(
      '/issues/evaluated',
      queryParameters: {'lastIssueId': lastIssueId},
    );
    final issuesDTO = IssuesDTO.fromJson(response.data);
    return issuesDTO.toDomain();
  }
}