import 'package:could_be/core/di/api_versions.dart';
import 'package:could_be/data/dto/notice_dto.dart';
import 'package:could_be/data/dto/notices_dto.dart';
import 'package:could_be/domain/entities/notice.dart';
import 'package:could_be/domain/entities/notices.dart';
import 'package:could_be/domain/repositoryInterfaces/notice_interface.dart';
import 'package:dio/dio.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final Dio dio;
  NoticeRepositoryImpl(this.dio);

  @override
  Future<Notice> fetchPopupNotice({String? lastNoticeId}) async {
    try {
      final response = await dio.get('${ApiVersions.v1}/notices/active');
      final dto = NoticeDto.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      throw Exception('Failed to fetch popup notice: $e');
    }
  }

  @override
  Future<Notices> fetchNotices({String? lastNoticeId}) async {
    try {
      final response = await dio.get('${ApiVersions.v1}/notices');
      final dto = NoticesDto.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      throw Exception('Failed to fetch notices: $e');
    }
  }

  @override
  Future<Notice> fetchNoticeById(String noticeId) async {
    try {
      final response = await dio.get('${ApiVersions.v1}/notices/$noticeId');
      final dto = NoticeDto.fromJson(response.data);
      return dto.toDomain();
    } catch (e) {
      throw Exception('Failed to fetch notice by ID: $e');
    }
  }
}