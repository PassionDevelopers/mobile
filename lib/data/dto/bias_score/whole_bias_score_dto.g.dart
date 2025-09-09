// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whole_bias_score_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholeBiasScoreDto _$WholeBiasScoreDtoFromJson(Map<String, dynamic> json) =>
    WholeBiasScoreDto(
      politics: BiasScoreDto.fromJson(json['politics'] as Map<String, dynamic>),
      economy: BiasScoreDto.fromJson(json['economy'] as Map<String, dynamic>),
      society: BiasScoreDto.fromJson(json['society'] as Map<String, dynamic>),
      culture: BiasScoreDto.fromJson(json['culture'] as Map<String, dynamic>),
      technology: BiasScoreDto.fromJson(
        json['technology'] as Map<String, dynamic>,
      ),
      international: BiasScoreDto.fromJson(
        json['international'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      userId: json['userId'] as String,
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
