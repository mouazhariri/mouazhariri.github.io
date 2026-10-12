// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatEntity _$StatEntityFromJson(Map<String, dynamic> json) => _StatEntity(
  labelKey: json['labelKey'] as String,
  value: (json['value'] as num).toInt(),
  suffix: json['suffix'] as String? ?? '+',
);

Map<String, dynamic> _$StatEntityToJson(_StatEntity instance) =>
    <String, dynamic>{
      'labelKey': instance.labelKey,
      'value': instance.value,
      'suffix': instance.suffix,
    };
