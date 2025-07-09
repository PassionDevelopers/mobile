
import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_issue_subscription_interface.dart';

class ManageIssueSubscriptionUseCase {
  final ManageIssueSubscriptionRepository _manageIssueSubscriptionRepository;

  ManageIssueSubscriptionUseCase(this._manageIssueSubscriptionRepository);

  Future<void> subscribeIssueByIssueId(String issueId) async {
    getIt<Amplitude>().track(AmplitudeEvents.subscribeIssue);
    await _manageIssueSubscriptionRepository.subscribeIssueByIssueId(issueId);
  }

  Future<void> unsubscribeIssueByIssueId(String issueId) async {
    getIt<Amplitude>().track(AmplitudeEvents.unsubscribeIssue);
    await _manageIssueSubscriptionRepository.unsubscribeIssueByIssueId(issueId);
  }

}