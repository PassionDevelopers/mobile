import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:could_be/domain/useCases/source/fetch_sources_use_case.dart';
import 'package:could_be/domain/useCases/source/manage_source_evaluation_use_case.dart';
import 'package:could_be/presentation/my_page/manage_source_evaluation/manage_source_evaluation_state.dart';
import 'package:flutter/cupertino.dart';

class ManageSourceEvaluationViewModel with ChangeNotifier{

  final ManageSourceEvaluationUseCase _manageSourceEvaluationUseCase;
  final FetchSourcesUseCase _fetchSourcesUseCase;
  ManageSourceEvaluationViewModel({
    required ManageSourceEvaluationUseCase manageSourceEvaluationUseCase,
    required FetchSourcesUseCase fetchSourcesUseCase,
  }) : _manageSourceEvaluationUseCase = manageSourceEvaluationUseCase,
        _fetchSourcesUseCase = fetchSourcesUseCase{
    fetchEvaluatedSources();
  }

  ManageSourceEvaluationState _state = ManageSourceEvaluationState();
  ManageSourceEvaluationState get state => _state;

  Future<void> fetchEvaluatedSources() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _fetchSourcesUseCase.fetchEvaluatedSources();

    _state = state.copyWith(
      sources: result,
      isLoading: false,
    );
    notifyListeners();
  }

  Future<void> manageSourceEvaluation({
    required String sourceId,
    required String perspective,
  }) async {
    await _manageSourceEvaluationUseCase.manageSourceEvaluation(
      sourceId: sourceId,
      perspective: perspective,
    );
    final bias  = getBiasFromString(perspective);
    _state = state.copyWith(
      sources: state.sources?.copyWith(
        sources: state.sources!.sources.map((source) {
          if (source.id == sourceId) {
            if(source.userEvaluatedPerspective == bias){
              return source.copyWith(userEvaluatedPerspective: null);
            }
            return source.copyWith(userEvaluatedPerspective: bias);
          }
          return source;
        }).toList(),
      ),
    );
    notifyListeners();
    showMyToast(msg: '언론 평가를 변경하였습니다.');
  }


}