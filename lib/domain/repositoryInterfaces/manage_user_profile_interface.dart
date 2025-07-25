import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';

abstract class ManageUserProfileRepository {

  Future<Result<bool, NickNameError>> updateUserNickname(String nickname);
}