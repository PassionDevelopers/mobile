import 'package:json_annotation/json_annotation.dart';
part 'coverage_spectrum_model.g.dart';

@JsonSerializable()
class CoverageSpectrumModel{
  final int left;
  final int right;
  @JsonKey(name: 'center_left')
  final int centerLeft;
  @JsonKey(name: 'center_right')
  final int centerRight;
  final int center;
  final int total;

  CoverageSpectrumModel({
    required this.left,
    required this.right,
    required this.center,
    required this.total,
    required this.centerLeft,
    required this.centerRight
  });

  factory CoverageSpectrumModel.fromJson(Map<String, dynamic> json) => _$CoverageSpectrumModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoverageSpectrumModelToJson(this);
}