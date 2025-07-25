// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_issues_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotIssuesDto _$HotIssuesDtoFromJson(Map<String, dynamic> json) => HotIssuesDto(
  issues:
      (json['issues'] as List<dynamic>)
          .map((e) => IssueDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasMore: json['hasMore'] as bool,
  lastIssueId: json['lastIssueId'] as String?,
  hotTime: DateTime.parse(json['hotTime'] as String),
);

Map<String, dynamic> _$HotIssuesDtoToJson(HotIssuesDto instance) =>
    <String, dynamic>{
      'issues': instance.issues,
      'hasMore': instance.hasMore,
      'lastIssueId': instance.lastIssueId,
      'hotTime': instance.hotTime.toIso8601String(),
    };
