import 'dart:developer';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:could_be/core/amplitude/amplitude.dart';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/domain/entities/user_register_status.dart';
import '../repositoryInterfaces/manage_user_status_interface.dart';

class ManageUserStatusUseCase{

  final ManageUserStatusRepository _manageUserStatusRepository;
  ManageUserStatusUseCase(this._manageUserStatusRepository);


  Future<UserRegisterStatus> checkUserRegisterStatus() async {
    getIt<Amplitude>().track(AmplitudeEvents.checkUserRegisterStatus);
    return await _manageUserStatusRepository.checkUserRegisterStatus();
  }

  Future<bool> registerIdToken(String idToken) async {
    getIt<Amplitude>().track(AmplitudeEvents.registerIdToken);
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

  Future<void> deleteUserAccount() async {
    getIt<Amplitude>().track(AmplitudeEvents.deleteUserAccountFromStatus);
    try {
      await _manageUserStatusRepository.deleteUserAccount();
    } catch (e) {
      log("Error deleting user account: $e");
    }
  }
}