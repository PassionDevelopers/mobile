import 'package:could_be/domain/repositoryInterfaces/report_interface.dart';

class ReportUseCase{
  final ReportRepository reportRepository;
  ReportUseCase({required this.reportRepository});

  Future<void> report({
    required String contentId,
    required String contentType,
    required String reason,
    String? description,
  }) async {
    await reportRepository.report(
      contentId: contentId,
      contentType: contentType,
      reason: reason,
      description: description,
    );
  }
}