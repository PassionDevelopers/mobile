// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverageModel _$CoverageModelFromJson(Map<String, dynamic> json) =>
    CoverageModel(
      totalArticles: (json['totalArticles'] as num).toInt(),
      totalSources: (json['totalSources'] as num).toInt(),
    );

Map<String, dynamic> _$CoverageModelToJson(CoverageModel instance) =>
    <String, dynamic>{
      'totalArticles': instance.totalArticles,
      'totalSources': instance.totalSources,
    };
