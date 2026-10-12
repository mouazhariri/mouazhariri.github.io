import 'package:freezed_annotation/freezed_annotation.dart';

part 'stat_entity.freezed.dart';
part 'stat_entity.g.dart';

/// A numeric fact shown in the hero / about sections (e.g. "+5 years").
@freezed
abstract class StatEntity with _$StatEntity {
  const factory StatEntity({
    required String labelKey,
    required int value,
    @Default('+') String suffix,
  }) = _StatEntity;

  factory StatEntity.fromJson(Map<String, dynamic> json) =>
      _$StatEntityFromJson(json);
}