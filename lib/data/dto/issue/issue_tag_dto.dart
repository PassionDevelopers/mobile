import 'dart:ui';
import 'package:could_be/domain/entities/issue/issue_tag.dart';
import 'package:json_annotation/json_annotation.dart';
part 'issue_tag_dto.g.dart';

@JsonSerializable()
class IssueTagDto {
  final String name;
  final String color;

  IssueTagDto(this.name, this.color);

  factory IssueTagDto.fromJson(Map<String, dynamic> json) =>
      _$IssueTagDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssueTagDtoToJson(this);
}

extension IssueTagDtoX on IssueTagDto {
  IssueTag toDomain() {
    return IssueTag(
      name: name,
      color: Color(int.parse('0xff${color.replaceAll('#', '')}')),
    );
  }
}
