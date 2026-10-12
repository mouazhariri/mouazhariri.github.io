// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectLinkEntity _$ProjectLinkEntityFromJson(Map<String, dynamic> json) =>
    _ProjectLinkEntity(
      type: $enumDecode(_$ProjectLinkTypeEnumMap, json['type']),
      url: json['url'] as String,
    );

Map<String, dynamic> _$ProjectLinkEntityToJson(_ProjectLinkEntity instance) =>
    <String, dynamic>{
      'type': _$ProjectLinkTypeEnumMap[instance.type]!,
      'url': instance.url,
    };

const _$ProjectLinkTypeEnumMap = {
  ProjectLinkType.appStore: 'app_store',
  ProjectLinkType.playStore: 'play_store',
  ProjectLinkType.web: 'web',
  ProjectLinkType.github: 'github',
};

_ProjectEntity _$ProjectEntityFromJson(Map<String, dynamic> json) =>
    _ProjectEntity(
      id: json['id'] as String,
      category: $enumDecode(_$ProjectCategoryEnumMap, json['category']),
      iconKey: json['iconKey'] as String,
      accentHex: json['accentHex'] as String,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      highlights:
          (json['highlights'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tech:
          (json['tech'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      links:
          (json['links'] as List<dynamic>?)
              ?.map(
                (e) => ProjectLinkEntity.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProjectEntityToJson(_ProjectEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': _$ProjectCategoryEnumMap[instance.category]!,
      'iconKey': instance.iconKey,
      'accentHex': instance.accentHex,
      'titleKey': instance.titleKey,
      'descriptionKey': instance.descriptionKey,
      'highlights': instance.highlights,
      'tech': instance.tech,
      'links': instance.links,
    };

const _$ProjectCategoryEnumMap = {
  ProjectCategory.eCommerce: 'e_commerce',
  ProjectCategory.services: 'services',
  ProjectCategory.delivery: 'delivery',
  ProjectCategory.productivity: 'productivity',
  ProjectCategory.social: 'social',
  ProjectCategory.entertainment: 'entertainment',
  ProjectCategory.webBackend: 'web_backend',
  ProjectCategory.finance: 'finance',
  ProjectCategory.other: 'other',
};
