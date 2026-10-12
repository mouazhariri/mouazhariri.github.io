import 'package:freezed_annotation/freezed_annotation.dart';

import 'portfolio_enums.dart';

part 'social_link_entity.freezed.dart';
part 'social_link_entity.g.dart';

/// A contact / social link (GitHub, LinkedIn, WhatsApp, Telegram, email).
@freezed
abstract class SocialLinkEntity with _$SocialLinkEntity {
  const factory SocialLinkEntity({
    required SocialLinkType type,
    required String url,
    required String labelKey,
  }) = _SocialLinkEntity;

  factory SocialLinkEntity.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkEntityFromJson(json);
}