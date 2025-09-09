// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_score_history_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasScoreHistoryDto _$BiasScoreHistoryDtoFromJson(Map<String, dynamic> json) =>
    BiasScoreHistoryDto(
      (json['history'] as List<dynamic>)
          .map((e) => BiasScoreElementDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BiasScoreHistoryDtoToJson(
  BiasScoreHistoryDto instance,
) => <String, dynamic>{'history': instance.history};
