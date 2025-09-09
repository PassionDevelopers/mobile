import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/user/user_register_status.dart';

part 'user_register_status_dto.g.dart';

@JsonSerializable()
class UserRegiterStatusDto {
  final bool exists;

  UserRegiterStatusDto(this.exists);

  factory UserRegiterStatusDto.fromJson(Map<String, dynamic> json) =>
      _$UserRegiterStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegiterStatusDtoToJson(this);
}

extension UserResiterStatusDtx on UserRegiterStatusDto {
  UserRegisterStatus toDomain() {
    return UserRegisterStatus(exists);
  }
}