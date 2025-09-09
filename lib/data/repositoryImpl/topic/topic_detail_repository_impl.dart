import 'package:dio/dio.dart';
import '../../../domain/entities/topic/topic_detail.dart';
import '../../../domain/repositoryInterfaces/topic/topic_detail_interface.dart';
import '../../dto/topic/topic_detail_dto.dart';

class TopicDetailRepositoryImpl implements TopicDetailRepository {
  final Dio _dio;

  TopicDetailRepositoryImpl(this._dio);

  @override
  Future<TopicDetail> fetchTopicDetailById(String id) async {
    final response = await _dio.get(
      '/topics/detail/$id',
    );
    final topicDetailDto = TopicDetailDto.fromJson(response.data);
    return topicDetailDto.toDomain();
  }
}