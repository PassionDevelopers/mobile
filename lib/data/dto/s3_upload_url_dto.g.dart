// GENERATED CODE - DO NOT MODIFY BY HAND

part of 's3_upload_url_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

S3UploadUrlDto _$S3UploadUrlDtoFromJson(Map<String, dynamic> json) =>
    S3UploadUrlDto(
      json['uploadUrl'] as String,
      json['uploadKey'] as String,
      json['expiresAt'] as String,
    );

Map<String, dynamic> _$S3UploadUrlDtoToJson(S3UploadUrlDto instance) =>
    <String, dynamic>{
      'uploadUrl': instance.uploadUrl,
      'uploadKey': instance.uploadKey,
      'expiresAt': instance.expiresAt,
    };
