import 'package:could_be/domain/entities/source/source.dart';

class Sources{
  final List<Source> sources;
  Sources({
    required this.sources,
  });

  Sources copyWith({
    List<Source>? sources,
  }) {
    return Sources(
      sources: sources ?? this.sources,
    );
  }
}