// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceDTO _$SourceDTOFromJson(Map<String, dynamic> json) => SourceDTO(
  id: json['_id'] as String,
  name: json['name'] as String,
  perspective: json['perspective'] as String,
  logoUrl: json['logoUrl'] as String,
  isSubscribed: json['isSubscribed'] as bool,
);

Map<String, dynamic> _$SourceDTOToJson(SourceDTO instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'perspective': instance.perspective,
  'logoUrl': instance.logoUrl,
  'isSubscribed': instance.isSubscribed,
};
