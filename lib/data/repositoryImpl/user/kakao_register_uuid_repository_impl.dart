import 'dart:convert';
import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/dto/custom_token_dto.dart';
import 'package:could_be/domain/repositoryInterfaces/kakao_register_uuid_interface.dart';
import 'package:dio/dio.dart';

class KakaoRegisterUuidRepositoryImpl implements KakaoRegisterUuidRepository {
  final Dio dio;
  KakaoRegisterUuidRepositoryImpl(this.dio);

  @override
  Future<String> registerKakaoUuid(String id) async {
    try {
      log('Registering Kakao UUID: $id');
      final response = await dio.post(
        '${ApiVersions.v1}/kakao',
        data: {'uid': id},
      );
      final Map<String, dynamic> responseData = jsonDecode(response.data.toString());
      final customTokenDto = CustomTokenDto.fromJson(responseData);
      return customTokenDto.customToken;

      if (response.statusCode != 200) {
        throw Exception('Failed to register Kakao UUID');
      }

    } catch (e) {
      throw Exception('Error registering Kakao UUID: $e');
    }
  }

}