

class PreviousIssueCache {
  PreviousIssueCache._();

  List<String> previousIssueIds = [];

  void savePreviousIssueIds(List<String> issueIds) {
    previousIssueIds = issueIds;
  }

  List<String> getPreviousIssueIds() {
    return previousIssueIds;
  }

  void addIssueId(String issueId) {
    if (!previousIssueIds.contains(issueId)) {
      previousIssueIds.add(issueId);
    }
  }

  void removeIssueId(String issueId) {
    previousIssueIds.remove(issueId);
  }

  void clear() {
    previousIssueIds.clear();
  }
}