import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/coverage_spectrum.dart';
part 'coverage_spectrum_dto.g.dart';

@JsonSerializable()
class CoverageSpectrumDTO{
  final int left;
  final int right;
  @JsonKey(name: 'center_left')
  final int centerLeft;
  @JsonKey(name: 'center_right')
  final int centerRight;
  final int center;
  final int total;

  CoverageSpectrumDTO({
    required this.left,
    required this.right,
    required this.center,
    required this.total,
    required this.centerLeft,
    required this.centerRight
  });

  factory CoverageSpectrumDTO.fromJson(Map<String, dynamic> json) => _$CoverageSpectrumDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CoverageSpectrumDTOToJson(this);
}

extension CoverageSpectrumDtx on CoverageSpectrumDTO {
  // Converts the DTO to a domain entity
  CoverageSpectrum toDomain() {
    return CoverageSpectrum(
      left: left,
      right: right,
      centerLeft: centerLeft,
      centerRight: centerRight,
      center: center,
      total: total,
    );
  }
}