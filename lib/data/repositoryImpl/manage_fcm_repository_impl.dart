import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_fcm_interface.dart';
import 'package:dio/dio.dart';

class ManageFcmRepositoryImpl extends ManageFcmRepository {
  final Dio dio;
  ManageFcmRepositoryImpl(this.dio);

  @override
  Future<void> updateFcmToken(String fcmToken) async {
    final response = await dio.post(
      '${ApiVersions.v1}/user/fcm',
      data: {'token': fcmToken},
    );
    log(response.data.toString());
  }

}