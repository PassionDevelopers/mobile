import 'package:could_be/core/method/bias/bias_enum.dart';
import 'package:could_be/domain/entities/comment/comment.dart';

class Comments {
  final Bias perspective;
  final List<Comment> comments;
  final bool hasMore;
  final String? lastCommentId;
  final int commentsCount;

  Comments({
    required this.perspective,
    required this.comments,
    this.hasMore = false,
    this.lastCommentId,
    required this.commentsCount,
  });
}
