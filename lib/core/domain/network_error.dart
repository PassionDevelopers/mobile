import 'error.dart';

enum NetworkError implements MyError{

  requestTimeout,
  noInternetConnection,
  serverError,
  // diskIO,
  // format,
  // unauthorized,
  // forbidden,
  // notFound,
  // conflict,
  // internalServerError,
  // badRequest,
  unknown;

  @override
  String toString() {
    switch (this) {
      case requestTimeout:
        return '요청 시간이 초과되었습니다.';
      // case format:
      //   return 'Invalid format';
      case noInternetConnection:
        return '인터넷 연결이 없습니다.';
      case serverError:
        return '서버 오류가 발생했습니다.';
      // case unauthorized:
      //   return 'Unauthorized access';
      // case forbidden:
      //   return 'Forbidden access';
      // case notFound:
      //   return 'Resource not found';
      // case conflict:
      //   return 'Conflict occurred';
      // case internalServerError:
      //   return 'Internal server error';
      // case badRequest:
      //   return 'Bad request';
      case unknown:
        return '알 수 없는 오류가 발생했습니다.';
    }
  }
}