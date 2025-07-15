import 'package:could_be/core/method/bias/bias_method.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/source.dart';
part 'source_dto.g.dart';

@JsonSerializable()
class SourceDTO {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String perspective;
  final String logoUrl;
  final bool isSubscribed;

  SourceDTO({
    required this.id,
    required this.name,
    required this.perspective,
    required this.logoUrl,
    required this.isSubscribed,
  });

  factory SourceDTO.fromJson(Map<String, dynamic> json) =>
      _$SourceDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SourceDTOToJson(this);
}

extension SourceDtx on SourceDTO {
  // Converts the DTO to a domain entity
  Source toDomain() {
    return Source(
      id: id,
      name: name,
      bias: getBiasFromString(perspective),
      logoUrl: logoUrl,
      isSubscribed: isSubscribed,
    );
  }
}
