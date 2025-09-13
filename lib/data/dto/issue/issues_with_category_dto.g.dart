// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_with_category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuesWithCategoryDto _$IssuesWithCategoryDtoFromJson(
  Map<String, dynamic> json,
) => IssuesWithCategoryDto(
  (json['issues'] as List<dynamic>)
      .map((e) => IssueDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['hasMore'] as bool,
  json['lastIssueId'] as String?,
  json['category'] as String,
);

Map<String, dynamic> _$IssuesWithCategoryDtoToJson(
  IssuesWithCategoryDto instance,
) => <String, dynamic>{
  'issues': instance.issues,
  'hasMore': instance.hasMore,
  'lastIssueId': instance.lastIssueId,
  'category': instance.category,
};
