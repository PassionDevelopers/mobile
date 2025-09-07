
import 'package:could_be/core/base_url.dart';
import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/domain/entities/sources.dart';
import 'package:dio/dio.dart';

import '../../domain/repositoryInterfaces/source/sources_interface.dart';
import '../dto/sources_dto.dart';

class SourcesRepositoryImpl extends SourcesRepository {
  final Dio dio;

  SourcesRepositoryImpl(this.dio);

  @override
  Future<Sources> fetchEvaluatedSources() async {
    final response = await dio.get(
        '${ApiVersions.v1}/media/evaluated',
    );
    final sourcesDTO = SourcesDTO.fromJson(response.data);
    return sourcesDTO.toDomain();
  }

  @override
  Future<Sources> fetchSubscribedSources() async {
    final response = await dio.get(
        '${ApiVersions.v1}/media/subscribed',
    );
    final sourcesDTO = SourcesDTO.fromJson(response.data);
    return sourcesDTO.toDomain();
  }

  @override
  Future<Sources> fetchAllSources() async {
    final response = await dio.get(
        '${ApiVersions.v1}/media',
    );
    final sourcesDTO = SourcesDTO.fromJson(response.data);
    return sourcesDTO.toDomain();
  }
}