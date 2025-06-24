
import '../entities/issue_detail.dart';
import '../repositoryInterfaces/issue_detail_interface.dart';

class FetchIssueDetailUseCase{
  final IssueDetailRepository _issueDetailRepository;

  const FetchIssueDetailUseCase(this._issueDetailRepository);

  Future<IssueDetail?> fetchIssueDetailById(String id) async {
    return _issueDetailRepository.fetchIssueDetailById(id);
  }
}