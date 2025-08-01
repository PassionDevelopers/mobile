import 'package:could_be/data/dto/notice_dto.dart';
import 'package:could_be/domain/entities/notices.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notices_dto.g.dart';

@JsonSerializable()
class NoticesDto {
  final List<NoticeDto> notices;
  final bool hasMore;
  final String? lastNoticeId;

  NoticesDto(this.notices, this.hasMore, this.lastNoticeId);

  factory NoticesDto.fromJson(Map<String, dynamic> json) =>
      _$NoticesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NoticesDtoToJson(this);
}

extension NoticesDtoExtension on NoticesDto {
  Notices toDomain() {
    return Notices(
      notices: notices.map((e) => e.toDomain()).toList(),
      hasMore: hasMore,
      lastNoticeId: lastNoticeId,
    );
  }
}