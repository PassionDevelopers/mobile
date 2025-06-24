
import 'package:could_be/domain/useCases/fetch_user_bias_user_case.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/entities/user_bias.dart';
import '../../domain/repositoryInterfaces/user_bias_interface.dart';
import '../dto/user_bias_dto.dart';

class UserBiasRepositoryImpl implements UserBiasRepository {
  final Dio dio;

  UserBiasRepositoryImpl(this.dio);

  @override
  Future<UserBias> fetchUserBias() async {
    final response = await dio.get(
      '/user/political-preference',
      options: Options(
        headers: {
          'Authorization' : demoToken
        },
      ),
    );
    final userBiasDTO = UserBiasDTO.fromJson(response.data);
    return userBiasDTO.toDomain();
  }
}