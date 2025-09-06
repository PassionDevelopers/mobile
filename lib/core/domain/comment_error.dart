

import 'package:could_be/core/domain/error.dart';

enum CommentError implements MyError{
  notProper,
  unknown;

  @override
  String toString() {
    switch (this) {
      case notProper:
        return '부적절한 댓글입니다.';
      case unknown:
        return '알 수 없는 오류가 발생했습니다.';
    }
  }
}