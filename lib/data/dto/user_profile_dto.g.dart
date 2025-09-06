// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDTO _$UserProfileDTOFromJson(Map<String, dynamic> json) =>
    UserProfileDTO(
      politicalPreference: json['politicalPreference'] as String,
      nickname: json['nickname'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UserProfileDTOToJson(UserProfileDTO instance) =>
    <String, dynamic>{
      'politicalPreference': instance.politicalPreference,
      'nickname': instance.nickname,
      'imageUrl': instance.imageUrl,
    };
