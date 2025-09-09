// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bias_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBiasDetailDto _$UserBiasDetailDtoFromJson(
  Map<String, dynamic> json,
) => UserBiasDetailDto(
  (json['politics'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  (json['economy'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  (json['society'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  (json['culture'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  (json['technology'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  (json['international'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  (json['overall'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
);

Map<String, dynamic> _$UserBiasDetailDtoToJson(UserBiasDetailDto instance) =>
    <String, dynamic>{
      'politics': instance.politics,
      'economy': instance.economy,
      'society': instance.society,
      'culture': instance.culture,
      'technology': instance.technology,
      'international': instance.international,
      'overall': instance.overall,
    };
