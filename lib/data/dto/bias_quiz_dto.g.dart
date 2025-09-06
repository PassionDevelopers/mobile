// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasQuizDto _$BiasQuizDtoFromJson(Map<String, dynamic> json) => BiasQuizDto(
  (json['id'] as num).toInt(),
  json['text'] as String,
  json['category'] as String,
  json['spectrum'] as String,
);

Map<String, dynamic> _$BiasQuizDtoToJson(BiasQuizDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'category': instance.category,
      'spectrum': instance.spectrum,
    };
