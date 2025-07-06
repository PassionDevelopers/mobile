class IssueQueryParams{
  final List<IssueQueryParam> queryParams;

  IssueQueryParams(this.queryParams);
}

class IssueQueryParam{
  final String queryParam;
  final String displayName;

  IssueQueryParam({
    required this.queryParam,
    required this.displayName,
  });

}