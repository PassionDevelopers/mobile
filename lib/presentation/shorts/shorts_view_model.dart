import 'package:could_be/domain/useCases/manage_issue_subscription_use_case.dart';
import 'package:could_be/presentation/shorts/shorts_state.dart';
import 'package:could_be/ui/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../domain/useCases/fetch_whole_issue_use_case.dart';

class ShortsViewModel with ChangeNotifier {
  final FetchIssueDetailUseCase _fetchIssueDetailUseCase;
  final ManageIssueSubscriptionUseCase manageIssueSubscriptionUseCase;
  final String issueId;

  //상태
  ShortsState _state = ShortsState();
  ShortsState get state => _state;

  ShortsViewModel({
    required this.issueId,
    required FetchIssueDetailUseCase fetchIssueDetailUseCase,
    required this.manageIssueSubscriptionUseCase,
  })  : _fetchIssueDetailUseCase = fetchIssueDetailUseCase{
    _fetchIssueDetailById();
  }

  void _fetchIssueDetailById() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _fetchIssueDetailUseCase.fetchIssueDetailById(issueId);

    _state = state.copyWith(
      issueDetail: result,
      isLoading: false,
    );
    print(state.issueDetail!.isSubscribed);
    notifyListeners();
  }

  void manageIssueSubscription() async {
    if(state.issueDetail!.isSubscribed){
      await manageIssueSubscriptionUseCase.unsubscribeIssueByIssueId(issueId);

    }else{
      await manageIssueSubscriptionUseCase.subscribeIssueByIssueId(issueId);
    }

    Fluttertoast.showToast(
        msg: state.issueDetail!.isSubscribed?
          "관심 이슈에서 해제하였습니다."
          : "관심 이슈로 등록하였습니다.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.gray3,
        textColor: AppColors.white,
        fontSize: 16.0
    );
    _state = state.copyWith(
      issueDetail: state.issueDetail!.copyWith(
        isSubscribed: !state.issueDetail!.isSubscribed,
      ),
    );

    notifyListeners();
  }

}