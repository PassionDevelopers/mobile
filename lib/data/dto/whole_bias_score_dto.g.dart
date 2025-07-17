// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whole_bias_score_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholeBiasScoreDto _$WholeBiasScoreDtoFromJson(Map<String, dynamic> json) =>
    WholeBiasScoreDto(
      BiasScoreDto.fromJson(json['politics'] as Map<String, dynamic>),
      BiasScoreDto.fromJson(json['economy'] as Map<String, dynamic>),
      BiasScoreDto.fromJson(json['society'] as Map<String, dynamic>),
      BiasScoreDto.fromJson(json['culture'] as Map<String, dynamic>),
      BiasScoreDto.fromJson(json['technology'] as Map<String, dynamic>),
      BiasScoreDto.fromJson(json['international'] as Map<String, dynamic>),
      DateTime.parse(json['createdAt'] as String),
      json['userId'] as String,
    );

Map<String, dynamic> _$WholeBiasScoreDtoToJson(WholeBiasScoreDto instance) =>
    <String, dynamic>{
      'politics': instance.politics,
      'economy': instance.economy,
      'society': instance.society,
      'culture': instance.culture,
      'technology': instance.technology,
      'international': instance.international,
      'createdAt': instance.createdAt.toIso8601String(),
      'userId': instance.userId,
    };
