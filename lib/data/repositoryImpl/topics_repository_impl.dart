import 'package:could_be/data/dto/topics_dto.dart';
import 'package:could_be/domain/entities/topics.dart';
import 'package:dio/dio.dart';

import '../../core/base_url.dart';
import '../../domain/repositoryInterfaces/topics_interface.dart';

class TopicsRepositoryImpl implements TopicsRepository {
  final Dio dio;

  TopicsRepositoryImpl(this.dio);

  @override
  Future<Topics> fetchSubscribedTopics() async {
    final response = await dio.get(
      '/topics/subscribed',
      options: Options(headers: {'Authorization': demoToken}),
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }

  @override
  Future<Topics> fetchSepecificCategoryTopics(String category) async {
    final response = await dio.get(
      '/topics',
      options: Options(headers: {
        'category': category,
        'Authorization': demoToken
      }),
    );
    final TopicsDto topicsDto = TopicsDto.fromJson(response.data);
    return topicsDto.toDomain();
  }
}
