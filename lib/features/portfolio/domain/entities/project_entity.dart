import 'package:freezed_annotation/freezed_annotation.dart';

import 'portfolio_enums.dart';

part 'project_entity.freezed.dart';
part 'project_entity.g.dart';

/// Store / market / demo link of a project.
@freezed
abstract class ProjectLinkEntity with _$ProjectLinkEntity {
  const factory ProjectLinkEntity({
    required ProjectLinkType type,
    required String url,
  }) = _ProjectLinkEntity;

  factory ProjectLinkEntity.fromJson(Map<String, dynamic> json) =>
      _$ProjectLinkEntityFromJson(json);
}

/// A portfolio project.
///
/// Translatable copy is stored as localization keys (`titleKey`,
/// `descriptionKey`) so EN/AR stay in sync (docs §11.4).
@freezed
abstract class ProjectEntity with _$ProjectEntity {
  const factory ProjectEntity({
    required String id,
    required ProjectCategory category,
    required String iconKey,
    required String accentHex,
    required String titleKey,
    required String descriptionKey,
    @Default([]) List<String> highlights,
    @Default([]) List<String> tech,
    @Default([]) List<ProjectLinkEntity> links,
  }) = _ProjectEntity;

  factory ProjectEntity.fromJson(Map<String, dynamic> json) =>
      _$ProjectEntityFromJson(json);
}