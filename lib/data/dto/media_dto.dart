import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/media.dart';
import 'medium_dto.dart';
part 'media_dto.g.dart';

@JsonSerializable()
class MediaDTO {
  final List<MediumDTO> media;
  final bool hasMore;
  final String lastMediaId;

  MediaDTO({
    required this.media,
    required this.hasMore,
    required this.lastMediaId,
  });

  factory MediaDTO.fromJson(Map<String, dynamic> json) =>
      _$MediaDTOFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDTOToJson(this);
}

extension MediaDtx on MediaDTO {
  // Converts the DTO to a domain entity
  Media toDomain() {
    return Media(
      media: media.map((medium) => medium.toDomain()).toList(),
      hasMore: hasMore,
      lastMediaId: lastMediaId,
    );
  }

}
