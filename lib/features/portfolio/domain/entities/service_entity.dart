import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_entity.freezed.dart';
part 'service_entity.g.dart';

/// A service offered (mobile development, architecture, backend, ...).
@freezed
abstract class ServiceEntity with _$ServiceEntity {
  const factory ServiceEntity({
    required String id,
    required String iconKey,
    required String accentHex,
    required String titleKey,
    required String descriptionKey,
    @Default([]) List<String> tags,
  }) = _ServiceEntity;

  factory ServiceEntity.fromJson(Map<String, dynamic> json) =>
      _$ServiceEntityFromJson(json);
}