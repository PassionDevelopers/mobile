// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bias_quiz_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BiasQuizResultDto _$BiasQuizResultDtoFromJson(Map<String, dynamic> json) =>
    BiasQuizResultDto(
      json['perspective'] as String,
      json['summary'] as String,
      json['dominantCategory'] as String,
      BiasQuizWholeBiasScoreDto.fromJson(
        json['scores'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$BiasQuizResultDtoToJson(BiasQuizResultDto instance) =>
    <String, dynamic>{
      'perspective': instance.perspective,
      'summary': instance.summary,
      'dominantCategory': instance.dominantCategory,
      'scores': instance.scores,
    };
