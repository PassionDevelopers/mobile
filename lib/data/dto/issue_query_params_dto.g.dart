// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_query_params_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssueQueryParamsDto _$IssueQueryParamsDtoFromJson(Map<String, dynamic> json) =>
    IssueQueryParamsDto(
      (json['queryParams'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$IssueQueryParamsDtoToJson(
  IssueQueryParamsDto instance,
) => <String, dynamic>{'queryParams': instance.queryParams};
