
import 'error.dart';

enum NickNameError implements MyError{
  alreadyExists,
  unknown;

  @override
  String toString() {
    switch (this) {
      case alreadyExists:
        return '이미 사용 중인 닉네임입니다.';
      case unknown:
        return '알 수 없는 오류가 발생했습니다.';
    }
  }
}