import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/dto/issue/hot_issues_dto.dart';
import 'package:could_be/domain/entities/issue/hot_issues.dart';
import 'package:could_be/domain/repositoryInterfaces/issue/hot_issues_interface.dart';
import 'package:dio/dio.dart';

class HotIssuesRepositoryImpl implements HotIssuesRepository {
  final Dio dio;
  HotIssuesRepositoryImpl(this.dio);

  @override
  Future<HotIssues> fetchHotIssues({String? lastIssueId}) async {
    final response = await dio.get(
      '${ApiVersions.v1}/issues/hot',
      queryParameters: {
        'lastIssueId': lastIssueId,
      }
    );
    final hotIssuesDto = HotIssuesDto.fromJson(response.data);
    return hotIssuesDto.toDomain();
  }
}