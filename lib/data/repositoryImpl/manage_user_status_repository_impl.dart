import 'dart:developer';

import 'package:could_be/domain/repositoryInterfaces/manage_user_status_interface.dart';
import 'package:dio/dio.dart';

class ManageUserStatusRepositoryImpl extends ManageUserStatusRepository{
  final Dio dio;
  ManageUserStatusRepositoryImpl(this.dio);

  @override
  Future<void> registerUserWithIdToken()async{
    final result = await dio.post(
      '/user/register'
      // data: {
      //   "perspective": "center"
      // }
    );
    log(result.data.toString());
  }

  @override
  Future<void> deleteUser()async{

  }
}