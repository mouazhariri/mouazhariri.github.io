// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialLinkEntity _$SocialLinkEntityFromJson(Map<String, dynamic> json) =>
    _SocialLinkEntity(
      type: $enumDecode(_$SocialLinkTypeEnumMap, json['type']),
      url: json['url'] as String,
      labelKey: json['labelKey'] as String,
    );

Map<String, dynamic> _$SocialLinkEntityToJson(_SocialLinkEntity instance) =>
    <String, dynamic>{
      'type': _$SocialLinkTypeEnumMap[instance.type]!,
      'url': instance.url,
      'labelKey': instance.labelKey,
    };

const _$SocialLinkTypeEnumMap = {
  SocialLinkType.github: 'github',
  SocialLinkType.linkedin: 'linkedin',
  SocialLinkType.whatsapp: 'whatsapp',
  SocialLinkType.telegram: 'telegram',
  SocialLinkType.email: 'email',
};
