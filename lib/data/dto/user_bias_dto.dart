import 'package:json_annotation/json_annotation.dart';

import '../../core/method/bias/bias_method.dart';
import '../../domain/entities/user_bias.dart';

part 'user_bias_dto.g.dart';

@JsonSerializable()
class UserBiasDTO {
  final String perspective;

  UserBiasDTO(this.perspective);

  factory UserBiasDTO.fromJson(Map<String, dynamic> json) =>
      _$UserBiasDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserBiasDTOToJson(this);
}

extension UserBiasDtx on UserBiasDTO {

  UserBias toDomain() {
    return UserBias(
      bias: getBiasFromString(perspective),
    );
  }
}