import '../entities/issues.dart';

abstract class IssuesRepository{
  Future<Issues> fetchDailyIssues();
  Future<Issues> fetchHotIssues();
  Future<Issues> fetchBlindSpotLeftIssues();
  Future<Issues> fetchBlindSpotRightIssues();
  Future<Issues> fetchForYouIssues();
  Future<Issues> fetchWatchHistoryIssues();
  Future<Issues> fetchSubscribedIssues();
}