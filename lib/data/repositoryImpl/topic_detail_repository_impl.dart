import 'package:could_be/core/base_url.dart';
import 'package:dio/dio.dart';
import '../../domain/entities/topic_detail.dart';
import '../../domain/repositoryInterfaces/topic_detail_interface.dart';
import '../dto/topic_detail_dto.dart';

class TopicDetailRepositoryImpl implements TopicDetailRepository {
  final Dio _dio;

  TopicDetailRepositoryImpl(this._dio);

  @override
  Future<TopicDetail> fetchTopicDetailById(String id) async {
    final response = await _dio.get(
      '/topics/detail/$id',
        options: Options(
          headers: {
            'Authorization': demoToken,
          },
        ),
    );
    final topicDetailDto = TopicDetailDto.fromJson(response.data);
    return topicDetailDto.toDomain();
  }
}