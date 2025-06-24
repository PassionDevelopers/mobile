import 'package:could_be/domain/entities/issue_detail.dart';
import 'package:dio/dio.dart';
import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/issue_detail_interface.dart';
import '../dto/issue_detail_dto.dart';

class IssueDetailRepositoryImpl implements IssueDetailRepository {
  final Dio dio;

  IssueDetailRepositoryImpl(this.dio);

  @override
  Future<IssueDetail?> fetchIssueDetailById(String id)async{
    final response = await dio.get(
      '/issues/$id',
      options: Options(
        headers: {
          'Authorization': demoToken,
        },
      ),
    );
    final issueDetailDTO = IssueDetailDTO.fromJson(response.data);
    return issueDetailDTO.toDomain();
  }
}