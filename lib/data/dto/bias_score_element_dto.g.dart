// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_score_element_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasScoreElementDto _$BiasScoreElementDtoFromJson(Map<String, dynamic> json) =>
    BiasScoreElementDto(
      period: PeriodInfoDto.fromJson(json['period'] as Map<String, dynamic>),
      score:
          json['score'] == null
              ? null
              : WholeBiasScoreOnlyDto.fromJson(
                json['score'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$BiasScoreElementDtoToJson(
  BiasScoreElementDto instance,
) => <String, dynamic>{'period': instance.period, 'score': instance.score};
