// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) =>
    _ProfileEntity(
      name: json['name'] as String,
      monogram: json['monogram'] as String,
      roleTitles:
          (json['roleTitles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      summaryKey: json['summaryKey'] as String,
      location: json['location'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      phoneLink: json['phoneLink'] as String,
      stats:
          (json['stats'] as List<dynamic>?)
              ?.map((e) => StatEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProfileEntityToJson(_ProfileEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'monogram': instance.monogram,
      'roleTitles': instance.roleTitles,
      'summaryKey': instance.summaryKey,
      'location': instance.location,
      'email': instance.email,
      'phone': instance.phone,
      'phoneLink': instance.phoneLink,
      'stats': instance.stats,
    };
