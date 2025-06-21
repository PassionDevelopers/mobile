import 'medium.dart';

class Media{
  final List<Medium> media;
  final bool hasMore;
  final String lastMediaId;

  Media({
    required this.media,
    required this.hasMore,
    required this.lastMediaId,
  });
}