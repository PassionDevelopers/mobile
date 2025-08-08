import 'dart:developer';

import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/core/analytics/unified_analytics_helper.dart';
import 'package:could_be/core/analytics/analytics_event_names.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';

class ManageUserProfileUseCase {
  final ManageUserProfileRepository manageUserProfileRepository;

  ManageUserProfileUseCase(this.manageUserProfileRepository);

  Future<Result<bool, NickNameError>> updateUserNickname(String name) async {
    UnifiedAnalyticsHelper.logEvent(
      name: AnalyticsEventNames.updateUserNickname,
      parameters: {
        'name_length': name.length.toString(),
      },
    );
    final result = await manageUserProfileRepository.updateUserNickname(name);
    return result;
  }
}