import 'package:json_annotation/json_annotation.dart';
part 'source_model.g.dart';

@JsonSerializable()
class SourceModel{
  @JsonKey(name: '_id')
  String id;
  String name;
  String perspective;

  SourceModel({
    required this.id,
    required this.name,
    required this.perspective,
  });

  factory SourceModel.fromJson(Map<String, dynamic> json) => _$SourceModelFromJson(json);
  Map<String, dynamic> toJson() => _$SourceModelToJson(this);
}