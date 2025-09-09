import 'package:could_be/domain/entities/user/user_register_status.dart';

abstract class ManageUserStatusRepository {

  Future<void> registerUserWithIdToken({
    required String? guestUid,
  });

  Future<UserRegisterStatus> checkUserRegisterStatus();

  Future<void> deleteUserAccount();
}