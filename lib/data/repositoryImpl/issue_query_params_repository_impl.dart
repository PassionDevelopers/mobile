import 'package:could_be/data/dto/issue_query_params_dto.dart';
import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/issue_query_params_interface.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';

class IssueQueryParamsRepositoryImpl extends IssueQueryParamsRepository{
  final Dio dio;
  IssueQueryParamsRepositoryImpl(this.dio);

  @override
  Future<IssueQueryParams> fetchIssueQueryParams()async{
    final response = await dio.get(
      '/issues/query-parmas',
      options: Options(
        headers: {
          'Authorization': demoToken,
        },
      ),
    );
    final issueQueryParamsDto = IssueQueryParamsDto.fromJson(response.data);
    return issueQueryParamsDto.toDomain();
  }
}