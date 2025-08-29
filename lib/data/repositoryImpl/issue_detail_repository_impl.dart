import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:dio/dio.dart';
import '../../domain/repositoryInterfaces/issue_detail_interface.dart';
import '../dto/issue_detail_dto.dart';

class IssueDetailRepositoryImpl implements IssueDetailRepository {
  final Dio dio;

  IssueDetailRepositoryImpl(this.dio);

  @override
  Future<IssueDetail?> fetchIssueDetailById(String id)async{
    final response = await dio.get(
      '${ApiVersions.v1}/issues/$id',

    );
    final issueDetailDTO = IssueDetailDTO.fromJson(response.data);
    return issueDetailDTO.toDomain();
  }
}