import 'package:could_be/domain/repositoryInterfaces/manage_user_status_interface.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';

class ManageUserStatusRepositoryImpl extends ManageUserStatusRepository{
  final Dio dio;
  ManageUserStatusRepositoryImpl(this.dio);

  @override
  Future<void> registerUser()async{
    final result = await dio.post(
      '/user/register',
      options: Options(
        headers: {
          'Authorization': demoToken,
        },
      ),
    );
  }

  @override
  Future<void> deleteUser()async{

  }
}