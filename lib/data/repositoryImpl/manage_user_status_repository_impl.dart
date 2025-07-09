import 'dart:developer';
import 'package:could_be/core/di/di_setup.dart';
import 'package:could_be/data/dto/user_register_status_dto.dart';
import 'package:could_be/domain/entities/user_register_status.dart';
import 'package:could_be/domain/repositoryInterfaces/manage_user_status_interface.dart';
import 'package:could_be/domain/repositoryInterfaces/token_storage_interface.dart';
import 'package:dio/dio.dart';

class ManageUserStatusRepositoryImpl extends ManageUserStatusRepository{
  final Dio dio;
  ManageUserStatusRepositoryImpl(this.dio);

  @override
  Future<UserRegisterStatus> checkUserRegisterStatus() async {
    final tokenStorageRepository = getIt<TokenStorageRepository>();
    final token = await tokenStorageRepository.getToken();
    log('last token check: $token');
    final result = await dio.get('/user/is-exists');
    final userRegisterStatusDto = UserRegiterStatusDto.fromJson(result.data);
    return userRegisterStatusDto.toDomain();
  }

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
  Future<void> deleteUserAccount()async{
    final result = await dio.delete(
        '/user/delete-account'
    );
    log(result.data.toString());
  }
}
