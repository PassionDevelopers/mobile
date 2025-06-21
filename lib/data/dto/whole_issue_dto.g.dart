// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whole_issue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholeIssueDTO _$WholeIssueDTOFromJson(Map<String, dynamic> json) =>
    WholeIssueDTO(
      issue: IssueDetailDTO.fromJson(json['issue'] as Map<String, dynamic>),
      articles: ArticlesDTO.fromJson(json['articles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WholeIssueDTOToJson(WholeIssueDTO instance) =>
    <String, dynamic>{'issue': instance.issue, 'articles': instance.articles};
