import 'dart:developer';
import 'package:could_be/core/di/api_versions.dart';
import 'package:dio/dio.dart';
import '../../core/base_url.dart';
import '../../domain/entities/source_detail.dart';
import '../../domain/repositoryInterfaces/source/source_detail_interface.dart';
import '../dto/source_detail_dto.dart';

class SourceDetailRepositoryImpl implements SourceDetailRepository {
  final Dio dio;

  SourceDetailRepositoryImpl(this.dio);

  @override
  Future<SourceDetail> fetchSourceDetailById(String sourceId) async {
    log('Fetching source detail for ID: $sourceId');
    final response = await dio.get(
      '${ApiVersions.v1}/media/$sourceId',

    );
    final sourceDetailDTO = SourceDetailDto.fromJson(response.data);
    return sourceDetailDTO.toDomain();
  }
}