
import 'error.dart';

sealed class Result<D, E extends MyError>{
  const factory Result.success(D data) = ResultSuccess;
  const factory Result.error(E error) = ResultError;
}


class ResultSuccess<D, E extends MyError> implements Result<D, E> {
  final D data;

  const ResultSuccess(this.data);
}

class ResultError<D, E extends MyError> implements Result<D, E> {
  final E error;

  const ResultError(this.error);
}

