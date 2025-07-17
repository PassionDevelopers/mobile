// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodInfoDto _$PeriodInfoDtoFromJson(Map<String, dynamic> json) =>
    PeriodInfoDto(
      year: (json['year'] as num?)?.toInt(),
      month: (json['month'] as num?)?.toInt(),
      week: (json['week'] as num?)?.toInt(),
      weekday: (json['weekday'] as num?)?.toInt(),
      day: (json['day'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PeriodInfoDtoToJson(PeriodInfoDto instance) =>
    <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'week': instance.week,
      'weekday': instance.weekday,
      'day': instance.day,
    };
