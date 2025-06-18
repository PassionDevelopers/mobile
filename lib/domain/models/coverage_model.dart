import 'package:json_annotation/json_annotation.dart';
part 'coverage_model.g.dart';

@JsonSerializable()
class CoverageModel{
  final int totalArticles;
  final int totalSources;

  CoverageModel({
    required this.totalArticles,
    required this.totalSources,
  });

  factory CoverageModel.fromJson(Map<String, dynamic> json) => _$CoverageModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoverageModelToJson(this);
}