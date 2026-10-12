import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill_entity.freezed.dart';
part 'skill_entity.g.dart';

/// A single skill, shown as a tag in the skills grid.
@freezed
abstract class SkillEntity with _$SkillEntity {
  const factory SkillEntity({
    required String name,
  }) = _SkillEntity;

  factory SkillEntity.fromJson(Map<String, dynamic> json) =>
      _$SkillEntityFromJson(json);
}

/// A group of skills (e.g. "Mobile Development").
@freezed
abstract class SkillGroupEntity with _$SkillGroupEntity {
  const factory SkillGroupEntity({
    required String id,
    required String groupKey,
    required String iconKey,
    @Default([]) List<SkillEntity> items,
  }) = _SkillGroupEntity;

  factory SkillGroupEntity.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupEntityFromJson(json);
}