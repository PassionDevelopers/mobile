import 'package:could_be/domain/entities/issue_query_params.dart';
import 'package:could_be/domain/repositoryInterfaces/issue_query_params_interface.dart';

class FetchIssueQueryParamsUseCase{
  final IssueQueryParamsRepository _issueQueryParamsRepository;
  FetchIssueQueryParamsUseCase(this._issueQueryParamsRepository);

  Future<IssueQueryParams> fetchIssueQueryParams() async {
    return await _issueQueryParamsRepository.fetchIssueQueryParams();
  }
}