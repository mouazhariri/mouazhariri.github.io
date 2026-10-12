// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SkillEntity _$SkillEntityFromJson(Map<String, dynamic> json) =>
    _SkillEntity(name: json['name'] as String);

Map<String, dynamic> _$SkillEntityToJson(_SkillEntity instance) =>
    <String, dynamic>{'name': instance.name};

_SkillGroupEntity _$SkillGroupEntityFromJson(Map<String, dynamic> json) =>
    _SkillGroupEntity(
      id: json['id'] as String,
      groupKey: json['groupKey'] as String,
      iconKey: json['iconKey'] as String,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => SkillEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SkillGroupEntityToJson(_SkillGroupEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'groupKey': instance.groupKey,
      'iconKey': instance.iconKey,
      'items': instance.items,
    };
