// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExperienceEntity _$ExperienceEntityFromJson(Map<String, dynamic> json) =>
    _ExperienceEntity(
      id: json['id'] as String,
      company: json['company'] as String,
      roleKey: json['roleKey'] as String,
      periodKey: json['periodKey'] as String,
      location: json['location'] as String,
      typeKey: json['typeKey'] as String,
      iconKey: json['iconKey'] as String,
      isEducation: json['isEducation'] as bool? ?? false,
      isCurrent: json['isCurrent'] as bool? ?? false,
      highlights:
          (json['highlights'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ExperienceEntityToJson(_ExperienceEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'roleKey': instance.roleKey,
      'periodKey': instance.periodKey,
      'location': instance.location,
      'typeKey': instance.typeKey,
      'iconKey': instance.iconKey,
      'isEducation': instance.isEducation,
      'isCurrent': instance.isCurrent,
      'highlights': instance.highlights,
    };
