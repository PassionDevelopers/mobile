import 'dart:developer';

import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/dto/topic/topics_dto.dart';
import 'package:could_be/domain/entities/topic/topics.dart';
import 'package:dio/dio.dart';
import '../../../domain/repositoryInterfaces/topic/topics_interface.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final Dio dio;

  TopicsRepositoryImpl(this.dio);

  @override
  Future<Topics> searchTopics(String query) async {
    log('Searching topics with query: $query');
    final response = await dio.get(
      '${ApiVersions.v1}/topics/search',
      queryParameters: {'q': query},
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }

  @override
  Future<Topics> fetchSubscribedTopics() async {
    final response = await dio.get(
      '${ApiVersions.v1}/topics/subscribed',
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }

  @override
  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    log('Fetching topics for category: $category');
    final response = await dio.get(
      '${ApiVersions.v1}/topics',
      queryParameters: {'category': category},
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }
}
