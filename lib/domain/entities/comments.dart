import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/comment.dart';

class Comments {
  final Bias perspective;
  final List<Comment> comments;
  final bool hasMore;
  final String? lastCommentId;

  Comments({
    required this.perspective,
    required this.comments,
    this.hasMore = false,
    this.lastCommentId,
  });
}
