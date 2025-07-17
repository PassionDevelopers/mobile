// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_score_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasScoreDto _$BiasScoreDtoFromJson(Map<String, dynamic> json) => BiasScoreDto(
  (json['left'] as num).toDouble(),
  (json['center'] as num).toDouble(),
  (json['right'] as num).toDouble(),
);

Map<String, dynamic> _$BiasScoreDtoToJson(BiasScoreDto instance) =>
    <String, dynamic>{
      'left': instance.left,
      'center': instance.center,
      'right': instance.right,
    };
