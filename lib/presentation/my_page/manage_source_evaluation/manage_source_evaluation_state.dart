import 'package:could_be/domain/entities/source/source.dart';
import 'package:could_be/domain/entities/source/sources.dart';

class ManageSourceEvaluationState{
  final bool isLoading;
  final Sources? sources;

  ManageSourceEvaluationState({
    this.isLoading = false,
    this.sources,
  });
  ManageSourceEvaluationState copyWith({
    bool? isLoading,
    Sources? sources,
  }) {
    return ManageSourceEvaluationState(
      isLoading: isLoading ?? this.isLoading,
      sources: sources ?? this.sources,
    );
  }
}