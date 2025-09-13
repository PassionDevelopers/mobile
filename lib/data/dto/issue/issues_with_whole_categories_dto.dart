import 'package:could_be/data/dto/issue/issues_with_category_dto.dart';
import 'package:could_be/domain/entities/issue/issues_with_whole_categories.dart';
import 'package:json_annotation/json_annotation.dart';

part 'issues_with_whole_categories_dto.g.dart';

@JsonSerializable()
class IssuesWithWholeCategoriesDto {
  final List<IssuesWithCategoryDto> categories;

  IssuesWithWholeCategoriesDto(this.categories);

  factory IssuesWithWholeCategoriesDto.fromJson(Map<String, dynamic> json) =>
      _$IssuesWithWholeCategoriesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$IssuesWithWholeCategoriesDtoToJson(this);
}

extension IssuesWithWholeCategoriesDtx on IssuesWithWholeCategoriesDto {
  IssuesWithWholeCategories toDomain() {
    return IssuesWithWholeCategories(
      categories.map((e) => e.toDomain()).toList(),
    );
  }
}