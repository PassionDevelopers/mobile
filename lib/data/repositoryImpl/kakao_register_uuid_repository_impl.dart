import 'dart:developer';

import 'package:could_be/domain/repositoryInterfaces/kakao_register_uuid_interface.dart';
import 'package:dio/dio.dart';

class KakaoRegisterUuidRepositoryImpl
    implements KakaoRegisterUuidRepository {
  final Dio dio;
  KakaoRegisterUuidRepositoryImpl(this.dio);

  @override
  Future<void> registerKakaoUuid(String uuid) async {
    try {
      final response = await dio.post(
        '/kakao',
        data: {'uid': uuid},
      );
      log('Kakao UUID registered: ${response.data}');
      if (response.statusCode != 200) {
        throw Exception('Failed to register Kakao UUID');
      }
    } catch (e) {
      throw Exception('Error registering Kakao UUID: $e');
    }
  }

}