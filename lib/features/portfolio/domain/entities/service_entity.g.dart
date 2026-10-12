// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServiceEntity _$ServiceEntityFromJson(Map<String, dynamic> json) =>
    _ServiceEntity(
      id: json['id'] as String,
      iconKey: json['iconKey'] as String,
      accentHex: json['accentHex'] as String,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
    );

Map<String, dynamic> _$ServiceEntityToJson(_ServiceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'iconKey': instance.iconKey,
      'accentHex': instance.accentHex,
      'titleKey': instance.titleKey,
      'descriptionKey': instance.descriptionKey,
      'tags': instance.tags,
    };
