// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dasi_score_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DasiScoreDto _$DasiScoreDtoFromJson(Map<String, dynamic> json) => DasiScoreDto(
  (json['score'] as num).toDouble(),
  json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  json['userId'] as String,
);

Map<String, dynamic> _$DasiScoreDtoToJson(DasiScoreDto instance) =>
    <String, dynamic>{
      'score': instance.score,
      'createdAt': instance.createdAt?.toIso8601String(),
      'userId': instance.userId,
    };
