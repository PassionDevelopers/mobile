import 'dart:developer';

import 'package:could_be/domain/entities/user_register_status.dart';
import '../repositoryInterfaces/manage_user_status_interface.dart';

class ManageUserStatusUseCase{

  final ManageUserStatusRepository _manageUserStatusRepository;
  ManageUserStatusUseCase(this._manageUserStatusRepository);


  Future<UserRegisterStatus> checkUserRegisterStatus() async {
    return await _manageUserStatusRepository.checkUserRegisterStatus();
  }

  Future<bool> registerIdToken(String idToken) async {
    try {
      final UserRegisterStatus userRegisterStatus = await _manageUserStatusRepository.checkUserRegisterStatus();
      if(!userRegisterStatus.exists){
        await _manageUserStatusRepository.registerUserWithIdToken();
      }
      return true;
    } catch (e) {
      log("Error storing ID token: $e");
      return false;
    }
  }
}