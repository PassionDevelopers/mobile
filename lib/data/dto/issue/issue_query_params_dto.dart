import 'package:could_be/domain/entities/issue/issue_query_params.dart';
import 'package:json_annotation/json_annotation.dart';
part 'issue_query_params_dto.g.dart';

@JsonSerializable()
class IssueQueryParamsDto {
  final List<List<String>> queryParams;

  IssueQueryParamsDto(this.queryParams);

  factory IssueQueryParamsDto.fromJson(Map<String, dynamic> json) =>
      _$IssueQueryParamsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssueQueryParamsDtoToJson(this);
}

extension IssueQueryParamsDtoExtension on IssueQueryParamsDto {
  IssueQueryParams toDomain() {
    return IssueQueryParams(queryParams.map((List<String> e) => IssueQueryParam(
      queryParam: e[0],
      displayName: e[1],
    )).toList());
  }
}
