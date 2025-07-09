import 'package:could_be/domain/entities/user_register_status.dart';

abstract class ManageUserStatusRepository {

  Future<void> registerUserWithIdToken();

  Future<UserRegisterStatus> checkUserRegisterStatus();

  Future<void> deleteUserAccount();
}