import 'package:could_be/domain/entities/notice.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notice_dto.g.dart';

@JsonSerializable()
class NoticeDto {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String? content;
  final bool isImportant;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoticeDto({
    required this.id,
    required this.title,
    this.content,
    required this.isImportant,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  factory NoticeDto.fromJson(Map<String, dynamic> json) =>
      _$NoticeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NoticeDtoToJson(this);
}

extension NoticeDtoExtension on NoticeDto {
  Notice toDomain() {
    return Notice(
      id: id,
      title: title,
      content: content,
      isImportant: isImportant,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}