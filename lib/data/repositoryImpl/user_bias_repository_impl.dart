import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/user_bias.dart';
import '../../domain/repositoryInterfaces/user_bias_interface.dart';
import '../dto/user_bias_dto.dart';

class UserBiasRepositoryImpl implements UserBiasRepository {
  final Dio dio;
  UserBiasRepositoryImpl(this.dio);

  @override
  Future<UserBias> fetchUserBias() async {
    final response = await dio.get(
      '${ApiVersions.v1}/user/political-preference',
    );
    final userBiasDTO = UserBiasDTO.fromJson(response.data);
    return userBiasDTO.toDomain();
  }
}