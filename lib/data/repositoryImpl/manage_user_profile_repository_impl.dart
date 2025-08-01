import 'dart:developer';

import 'package:could_be/core/components/alert/toast.dart';
import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/core/domain/nick_name_error.dart';
import 'package:could_be/core/domain/result.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';
import 'package:dio/dio.dart';

class ManageUserProfileRepositoryImpl extends ManageUserProfileRepository {
    final Dio dio;
    ManageUserProfileRepositoryImpl(this.dio);
    @override
    Future<Result<bool, NickNameError>> updateUserNickname(String name) async {
      final response = await dio.put(
        '${ApiVersions.v1}/user/nickname',
        data: {
          'nickname': name,
        },
      ).onError((DioException e, stackTrace) {
        return e.response ?? Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode ?? 999,
        );
      });

      switch(response.statusCode) {
        case 200:
          return Result.success(true);
        case 409:
          return Result.error(NickNameError.alreadyExists);
        default:
          return Result.error(NickNameError.unknown);
      }
    }
}