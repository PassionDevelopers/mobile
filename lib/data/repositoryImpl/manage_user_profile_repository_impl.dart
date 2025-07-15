import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_profile_interface.dart';
import 'package:dio/dio.dart';

class ManageUserProfileRepositoryImpl extends ManageUserProfileRepository {
    final Dio dio;
    ManageUserProfileRepositoryImpl(this.dio);
    @override
    Future<void> updateUserNickname(String name) async {
      await dio.put(
        '${ApiVersions.v1}/user/nickname',
        data: {
          'nickname': name,
        },
      );
    }

}