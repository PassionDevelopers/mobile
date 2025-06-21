// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage_spectrum_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverageSpectrumDTO _$CoverageSpectrumDTOFromJson(Map<String, dynamic> json) =>
    CoverageSpectrumDTO(
      left: (json['left'] as num).toInt(),
      right: (json['right'] as num).toInt(),
      center: (json['center'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      centerLeft: (json['center_left'] as num).toInt(),
      centerRight: (json['center_right'] as num).toInt(),
    );

Map<String, dynamic> _$CoverageSpectrumDTOToJson(
  CoverageSpectrumDTO instance,
) => <String, dynamic>{
  'left': instance.left,
  'right': instance.right,
  'center_left': instance.centerLeft,
  'center_right': instance.centerRight,
  'center': instance.center,
  'total': instance.total,
};
