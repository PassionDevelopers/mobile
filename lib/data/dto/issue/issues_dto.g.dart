// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuesDTO _$IssuesDTOFromJson(Map<String, dynamic> json) => IssuesDTO(
  issues:
      (json['issues'] as List<dynamic>)
          .map((e) => IssueDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
  hasMore: json['hasMore'] as bool,
  lastIssueId: json['lastIssueId'] as String?,
);

Map<String, dynamic> _$IssuesDTOToJson(IssuesDTO instance) => <String, dynamic>{
  'issues': instance.issues,
  'hasMore': instance.hasMore,
  'lastIssueId': instance.lastIssueId,
};
