import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience_entity.freezed.dart';
part 'experience_entity.g.dart';

/// A job (or education) entry on the timeline.
@freezed
abstract class ExperienceEntity with _$ExperienceEntity {
  const factory ExperienceEntity({
    required String id,
    required String company,
    required String roleKey,
    required String periodKey,
    required String location,
    required String typeKey,
    required String iconKey,
    @Default(false) bool isEducation,
    @Default(false) bool isCurrent,
    @Default([]) List<String> highlights,
  }) = _ExperienceEntity;

  factory ExperienceEntity.fromJson(Map<String, dynamic> json) =>
      _$ExperienceEntityFromJson(json);
}