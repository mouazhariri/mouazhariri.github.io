/// Domain enums for portfolio data.
///
/// `@JsonValue` keeps the wire/asset format (`snake_case`) independent from
/// Dart identifiers.
library;

import 'package:json_annotation/json_annotation.dart';

enum SocialLinkType {
  @JsonValue('github')
  github,
  @JsonValue('linkedin')
  linkedin,
  @JsonValue('whatsapp')
  whatsapp,
  @JsonValue('telegram')
  telegram,
  @JsonValue('email')
  email,
}

enum ProjectCategory {
  @JsonValue('e_commerce')
  eCommerce,
  @JsonValue('services')
  services,
  @JsonValue('delivery')
  delivery,
  @JsonValue('productivity')
  productivity,
  @JsonValue('social')
  social,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('web_backend')
  webBackend,
  @JsonValue('finance')
  finance,
  @JsonValue('other')
  other,
}

enum ProjectLinkType {
  @JsonValue('app_store')
  appStore,
  @JsonValue('play_store')
  playStore,
  @JsonValue('web')
  web,
  @JsonValue('github')
  github,
}