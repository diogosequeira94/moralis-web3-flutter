import 'package:json_annotation/json_annotation.dart';

part 'nft.g.dart';

@JsonSerializable()
class NFT {
  @JsonKey(name: 'normalized_metadata')
  final NormalizedMetadata? normalizedMetadata;

  const NFT(this.normalizedMetadata);

  factory NFT.fromJson(Map<String, dynamic> json) => _$NFTFromJson(json);

  Map<String, dynamic> toJson() => _$NFTToJson(this);
}

@JsonSerializable()
class NormalizedMetadata {
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'image')
  final String? imageUrl;

  const NormalizedMetadata(this.description, this.imageUrl);

  factory NormalizedMetadata.fromJson(Map<String, dynamic> json) =>
      _$NormalizedMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$NormalizedMetadataToJson(this);
}
