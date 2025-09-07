import 'dart:developer';

import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/domain/entities/user_register_status.dart';
import '../repositoryInterfaces/user/manage_user_status_interface.dart';

class ManageUserStatusUseCase{

  final ManageUserStatusRepository _manageUserStatusRepository;
  ManageUserStatusUseCase(this._manageUserStatusRepository);


  Future<UserRegisterStatus> checkUserRegisterStatus() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.checkUserRegisterStatus,
    );
    return await _manageUserStatusRepository.checkUserRegisterStatus();
  }

  Future<bool> registerIdToken({required String? guestUid}) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.registerIdToken,
      parameters: {
        'has_guest_uid': (guestUid != null).toString(),
      },
    );
    try {
      final UserRegisterStatus userRegisterStatus = await _manageUserStatusRepository.checkUserRegisterStatus();
      if(!userRegisterStatus.exists){
        await _manageUserStatusRepository.registerUserWithIdToken(guestUid: guestUid);
      }
      return true;
    } catch (e) {
      log("Error storing ID token: $e");
      return false;
    }
  }

  Future<void> deleteUserAccount() async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.deleteUserAccount,
    );
    try {
      await _manageUserStatusRepository.deleteUserAccount();
    } catch (e) {
      log("Error deleting user account: $e");
    }
  }
}