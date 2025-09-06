import 'package:could_be/domain/entities/s3_upload_url.dart';
import 'package:json_annotation/json_annotation.dart';

part 's3_upload_url_dto.g.dart';

@JsonSerializable()
class S3UploadUrlDto {
  final String uploadUrl;
  final String uploadKey;
  final String expiresAt;

  S3UploadUrlDto(this.uploadUrl, this.uploadKey, this.expiresAt);

  factory S3UploadUrlDto.fromJson(Map<String, dynamic> json) =>
      _$S3UploadUrlDtoFromJson(json);

  Map<String, dynamic> toJson() => _$S3UploadUrlDtoToJson(this);
}

extension S3UploadUrlDtx on S3UploadUrlDto {
  S3UploadUrl toDomain() {
    return S3UploadUrl(
      uploadUrl: uploadUrl,
      uploadKey: uploadKey,
    );
  }
}