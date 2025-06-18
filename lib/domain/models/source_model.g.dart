// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceModel _$SourceModelFromJson(Map<String, dynamic> json) => SourceModel(
  id: json['_id'] as String,
  name: json['name'] as String,
  perspective: json['perspective'] as String,
);

Map<String, dynamic> _$SourceModelToJson(SourceModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'perspective': instance.perspective,
    };
