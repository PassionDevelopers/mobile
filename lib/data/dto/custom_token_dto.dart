import 'package:json_annotation/json_annotation.dart';

part 'custom_token_dto.g.dart';

@JsonSerializable()
class CustomTokenDto {
  @JsonKey(name: 'custom_token')
  final String customToken;

  CustomTokenDto(this.customToken);

  factory CustomTokenDto.fromJson(Map<String, dynamic> json) =>
      _$CustomTokenDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CustomTokenDtoToJson(this);
}
