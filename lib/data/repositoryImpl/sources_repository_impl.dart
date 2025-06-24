
import 'package:could_be/core/base_url.dart';
import 'package:could_be/domain/entities/sources.dart';
import 'package:dio/dio.dart';

import '../../domain/repositoryInterfaces/sources_interface.dart';
import '../dto/sources_dto.dart';

class SourcesRepositoryImpl extends SourcesRepository {
  final Dio dio;

  SourcesRepositoryImpl(this.dio);

  @override
  Future<Sources> fetchSubscribedSources() async {
    final response = await dio.get(
        '/media/subscribed',
        options: Options(
          headers: {
            'Authorization': demoToken
          },
        )
    );
    final sourcesDTO = SourcesDTO.fromJson(response.data);
    return sourcesDTO.toDomain();
  }

  @override
  Future<Sources> fetchAllSources() async {
    final response = await dio.get(
        '/media',
        options: Options(
          headers: {
            'Authorization': demoToken
          },
        )
    );
    final sourcesDTO = SourcesDTO.fromJson(response.data);
    return sourcesDTO.toDomain();
  }
}