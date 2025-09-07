// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_quiz_whole_bias_score_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasQuizWholeBiasScoreDto _$BiasQuizWholeBiasScoreDtoFromJson(
  Map<String, dynamic> json,
) => BiasQuizWholeBiasScoreDto(
  BiasScoreDto.fromJson(json['politics'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['economy'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['society'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['culture'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['technology'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['international'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BiasQuizWholeBiasScoreDtoToJson(
  BiasQuizWholeBiasScoreDto instance,
) => <String, dynamic>{
  'politics': instance.politics,
  'economy': instance.economy,
  'society': instance.society,
  'culture': instance.culture,
  'technology': instance.technology,
  'international': instance.international,
};
