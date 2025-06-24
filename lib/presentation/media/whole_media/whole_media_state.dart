

import 'package:could_be/domain/entities/sources.dart';

class WholeMediaState{
  bool isLoading;
  Sources? sources;

  WholeMediaState({
    this.isLoading = false,
    this.sources,
  });

  WholeMediaState copyWith({
    bool? isLoading,
    Sources? sources,
  }) {
    return WholeMediaState(
      isLoading: isLoading ?? this.isLoading,
      sources: sources ?? this.sources,
    );
  }
}