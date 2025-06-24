// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sources_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourcesDTO _$SourcesDTOFromJson(Map<String, dynamic> json) => SourcesDTO(
  (json['sources'] as List<dynamic>)
      .map((e) => SourceDTO.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SourcesDTOToJson(SourcesDTO instance) =>
    <String, dynamic>{'sources': instance.sources};
