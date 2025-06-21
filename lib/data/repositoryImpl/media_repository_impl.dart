import 'package:dio/dio.dart';
import '../../core/base_url.dart';
import '../../domain/entities/media.dart';
import '../../domain/repositoryInterfaces/media_interface.dart';
import '../dto/media_dto.dart';

class MediaRepositoryImpl implements MediaRepository {
  final Dio dio;
  MediaRepositoryImpl(this.dio);

  @override
  Future<Media> fetchSubscribedMedia() async {
    final response = await dio.get(
      '/media',
      options: Options(
        headers: {
          'Authorization' : demoToken
        },
      ),
      queryParameters: {'type': 'subscribed', 'limit': 2, 'lastIssueId': ''},
    );
    final mediaDTO = MediaDTO.fromJson(response.data);
    return mediaDTO.toDomain();
  }
}