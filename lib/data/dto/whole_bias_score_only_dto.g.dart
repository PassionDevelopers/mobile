// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'whole_bias_score_only_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WholeBiasScoreOnlyDto _$WholeBiasScoreOnlyDtoFromJson(
  Map<String, dynamic> json,
) => WholeBiasScoreOnlyDto(
  BiasScoreDto.fromJson(json['politics'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['economy'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['society'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['culture'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['technology'] as Map<String, dynamic>),
  BiasScoreDto.fromJson(json['international'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WholeBiasScoreOnlyDtoToJson(
  WholeBiasScoreOnlyDto instance,
) => <String, dynamic>{
  'politics': instance.politics,
  'economy': instance.economy,
  'society': instance.society,
  'culture': instance.culture,
  'technology': instance.technology,
  'international': instance.international,
};
