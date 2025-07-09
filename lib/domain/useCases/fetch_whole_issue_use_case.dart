
import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import '../entities/issue_detail.dart';
import '../repositoryInterfaces/issue_detail_interface.dart';

class FetchIssueDetailUseCase{
  final IssueDetailRepository _issueDetailRepository;

  const FetchIssueDetailUseCase(this._issueDetailRepository);

  Future<IssueDetail?> fetchIssueDetailById(String id) async {
    getIt<Amplitude>().track(AmplitudeEvents.fetchIssueDetailById);
    return _issueDetailRepository.fetchIssueDetailById(id);
  }
}