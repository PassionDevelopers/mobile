import '../entities/issues.dart';

abstract class IssuesRepository{
  Future<Issues> fetchDailyIssues();
  Future<Issues> fetchHotIssues();
  Future<Issues> fetchBlindSpotIssues();
  Future<Issues> fetchForYouIssues();
}