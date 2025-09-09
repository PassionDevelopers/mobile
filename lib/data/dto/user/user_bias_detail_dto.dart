import 'package:json_annotation/json_annotation.dart';

part 'user_bias_detail_dto.g.dart';

@JsonSerializable()
class UserBiasDetailDto {
  final List<int> politics;
  final List<int> economy;
  final List<int> society;
  final List<int> culture;
  final List<int> technology;
  final List<int> international;
  final List<int> overall;

  UserBiasDetailDto(
    this.politics,
    this.economy,
    this.society,
    this.culture,
    this.technology,
    this.international,
    this.overall,
  );

  factory UserBiasDetailDto.fromJson(Map<String, dynamic> json) =>
      _$UserBiasDetailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserBiasDetailDtoToJson(this);
}
