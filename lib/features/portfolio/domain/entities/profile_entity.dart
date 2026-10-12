import 'package:freezed_annotation/freezed_annotation.dart';

import 'stat_entity.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

/// Personal profile data (name, roles, contact, stats).
@freezed
abstract class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String name,
    required String monogram,
    @Default([]) List<String> roleTitles,
    required String summaryKey,
    required String location,
    required String email,
    required String phone,
    required String phoneLink,
    @Default([]) List<StatEntity> stats,
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileEntityFromJson(json);
}