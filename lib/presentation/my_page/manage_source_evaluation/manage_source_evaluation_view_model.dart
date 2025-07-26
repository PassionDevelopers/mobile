import 'package:could_be/domain/useCases/fetch_sources_use_case.dart';
import 'package:could_be/domain/useCases/manage_source_evaluation_use_case.dart';
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
  }


}