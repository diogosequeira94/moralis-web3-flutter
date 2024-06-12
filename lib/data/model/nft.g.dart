// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NFT _$NFTFromJson(Map<String, dynamic> json) => NFT(
      json['normalized_metadata'] == null
          ? null
          : NormalizedMetadata.fromJson(
              json['normalized_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NFTToJson(NFT instance) => <String, dynamic>{
      'normalized_metadata': instance.normalizedMetadata,
    };

NormalizedMetadata _$NormalizedMetadataFromJson(Map<String, dynamic> json) =>
    NormalizedMetadata(
      json['description'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$NormalizedMetadataToJson(NormalizedMetadata instance) =>
    <String, dynamic>{
      'description': instance.description,
      'image': instance.imageUrl,
    };
