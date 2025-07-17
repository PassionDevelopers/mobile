import 'package:could_be/domain/entities/period_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'period_info_dto.g.dart';

@JsonSerializable()
class PeriodInfoDto {
  final int? year;
  final int? month;
  final int? week;
  final int? weekday;
  final int? day;

  PeriodInfoDto({
    this.year,
    this.month,
    this.week,
    this.weekday,
    this.day,
  });

  factory PeriodInfoDto.fromJson(Map<String, dynamic> json) =>
      _$PeriodInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PeriodInfoDtoToJson(this);
}

extension PeriodInfoDtx on PeriodInfoDto {
  PeriodInfo toDomain() {
    return PeriodInfo(
      year: year,
      month: month,
      week: week,
      weekday: weekday,
      day: day,
    );
  }
}