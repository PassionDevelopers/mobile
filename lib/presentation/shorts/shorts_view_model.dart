import 'package:could_be/presentation/shorts/shorts_state.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';

class ShortsViewModel with ChangeNotifier {
  final FetchWholeIssueUseCase _fetchWholeIssueUseCase;
  final String issueId;

  //상태
  ShortsState _state = ShortsState();
  ShortsState get state => _state;

  ShortsViewModel({
    required this.issueId,
    required FetchWholeIssueUseCase fetchWholeIssueUseCase,
  })  : _fetchWholeIssueUseCase = fetchWholeIssueUseCase{
    _fetchWholeIssueById();
  }

  void _fetchWholeIssueById() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchWholeIssueUseCase.fetchWholeIssueById(issueId);
    print(result);
    _state = state.copyWith(
      wholeIssue: result,
      isLoading: false,
    );
    notifyListeners();
  }
}