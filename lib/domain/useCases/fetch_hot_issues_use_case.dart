import 'package:could_be/domain/entities/hot_issues.dart';
import 'package:could_be/domain/repositoryInterfaces/hot_issues_interface.dart';

class FetchHotIssuesUseCase {
  final HotIssuesRepository _repository;

  FetchHotIssuesUseCase(this._repository);

  Future<HotIssues> fetchHotIssues({String? lastIssueId}) async {
    return await _repository.fetchHotIssues(lastIssueId: lastIssueId,);
  }

}