import 'package:dio/dio.dart';
import '../../domain/entities/whole_issue.dart';
import '../../domain/repositoryInterfaces/whole_issue_interface.dart';
import '../dto/whole_issue_dto.dart';

class WholeIssueRepositoryImpl implements WholeIssueRepository {
  final Dio dio;

  WholeIssueRepositoryImpl(this.dio);

  @override
  Future<WholeIssue?> fetchWholeIssueById(String id)async{
    final response = await dio.get(
      '/issues/$id',
    );
    final wholeIssueDTO = WholeIssueDTO.fromJson(response.data);
    return wholeIssueDTO.toDomain();
  }
}