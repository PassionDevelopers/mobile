import 'package:could_be/domain/repositoryInterfaces/report_interface.dart';
import 'package:dio/dio.dart';

class ReportRepositoryImpl extends ReportRepository {
  final Dio dio;

  ReportRepositoryImpl(this.dio);

  @override
  Future<void> report({
    required String contentId,
    required String contentType,
    required String reason,
    String? description,
  }) async {
    await dio.post(
      '/reports',
      data: {
        'contentId': contentId,
        'contentType': contentType,
        'reason': reason,
        if (description != null) 'description': description,
      },
    );
  }


}