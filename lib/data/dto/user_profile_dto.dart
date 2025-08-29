import 'package:could_be/domain/entities/user_profile.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/method/bias/bias_method.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserProfileDTO {
  final String? userId;
  final String politicalPreference;
  final String? nickname;
  final String? imageUrl;

  UserProfileDTO({
    required this.politicalPreference,
    this.userId,
    this.nickname,
    this.imageUrl,
});

  factory UserProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDTOToJson(this);
}

extension UserProfileDtx on UserProfileDTO {

  UserProfile toDomain() {
    return UserProfile(
      userId: userId,
      nickname: nickname,
      bias: getBiasFromString(politicalPreference),
      imageUrl: imageUrl,
    );
  }
}