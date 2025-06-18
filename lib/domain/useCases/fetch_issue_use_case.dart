import 'package:could_be/domain/repositoryInterfaces/issue_interface.dart';
import 'package:get/get_connect/connect.dart';
import '../../core/base_url.dart';
import '../entities/issue.dart';

class FetchIssueUseCase{
  final IssueRepository _issueRepository;

  FetchIssueUseCase(this._issueRepository);


  static Future<Map<String, dynamic>?> dailyIssues() async {
    try {
      final response = await GetConnect().get(baseUrl + '/issues');
      if (response.status.hasError) {
        throw Exception('Failed to load issues');
      }
      return response.body;
    } catch (e) {
      print('Error fetching issues: $e');
      return null;
    }
  }


}