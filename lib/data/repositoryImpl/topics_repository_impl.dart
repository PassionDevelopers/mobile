import 'dart:developer';

import 'package:could_be/data/dto/topics_dto.dart';
import 'package:could_be/domain/entities/topics.dart';
import 'package:dio/dio.dart';
import '../../domain/repositoryInterfaces/topics_interface.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final Dio dio;

  TopicsRepositoryImpl(this.dio);

  @override
  Future<Topics> fetchSubscribedTopics() async {
    final response = await dio.get(
      '/topics/subscribed',
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }

  @override
  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    log('Fetching topics for category: $category');
    final response = await dio.get(
      '/topics',
      queryParameters: {'category': category},
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }
}
