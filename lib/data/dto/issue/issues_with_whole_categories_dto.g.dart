// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_with_whole_categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IssuesWithWholeCategoriesDto _$IssuesWithWholeCategoriesDtoFromJson(
  Map<String, dynamic> json,
) => IssuesWithWholeCategoriesDto(
  (json['categories'] as List<dynamic>)
      .map((e) => IssuesWithCategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$IssuesWithWholeCategoriesDtoToJson(
  IssuesWithWholeCategoriesDto instance,
) => <String, dynamic>{'categories': instance.categories};
