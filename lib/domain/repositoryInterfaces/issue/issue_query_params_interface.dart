import '../../entities/issue_query_params.dart';

abstract class IssueQueryParamsRepository{
  Future<IssueQueryParams>fetchIssueQueryParams();
}