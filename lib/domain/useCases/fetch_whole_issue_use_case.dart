import 'package:could_be/domain/entities/whole_issue.dart';
import 'package:could_be/domain/repositoryInterfaces/whole_issue_interface.dart';

class FetchWholeIssueUseCase{
  final WholeIssueRepository _wholeIssueRepository;

  const FetchWholeIssueUseCase(this._wholeIssueRepository);

  Future<WholeIssue?> fetchWholeIssueById(String id) async {
    return _wholeIssueRepository.fetchWholeIssueById(id);
  }
}