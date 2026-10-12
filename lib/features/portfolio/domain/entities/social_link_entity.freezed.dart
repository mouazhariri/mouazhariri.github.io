// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_link_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialLinkEntity {

 SocialLinkType get type; String get url; String get labelKey;
/// Create a copy of SocialLinkEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinkEntityCopyWith<SocialLinkEntity> get copyWith => _$SocialLinkEntityCopyWithImpl<SocialLinkEntity>(this as SocialLinkEntity, _$identity);

  /// Serializes this SocialLinkEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLinkEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.labelKey, labelKey) || other.labelKey == labelKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url,labelKey);

@override
String toString() {
  return 'SocialLinkEntity(type: $type, url: $url, labelKey: $labelKey)';
}


}

/// @nodoc
abstract mixin class $SocialLinkEntityCopyWith<$Res>  {
  factory $SocialLinkEntityCopyWith(SocialLinkEntity value, $Res Function(SocialLinkEntity) _then) = _$SocialLinkEntityCopyWithImpl;
@useResult
$Res call({
 SocialLinkType type, String url, String labelKey
});




}
/// @nodoc
class _$SocialLinkEntityCopyWithImpl<$Res>
    implements $SocialLinkEntityCopyWith<$Res> {
  _$SocialLinkEntityCopyWithImpl(this._self, this._then);

  final SocialLinkEntity _self;
  final $Res Function(SocialLinkEntity) _then;

/// Create a copy of SocialLinkEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? url = null,Object? labelKey = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialLinkType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,labelKey: null == labelKey ? _self.labelKey : labelKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLinkEntity].
extension SocialLinkEntityPatterns on SocialLinkEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLinkEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLinkEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLinkEntity value)  $default,){
final _that = this;
switch (_that) {
case _SocialLinkEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLinkEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLinkEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SocialLinkType type,  String url,  String labelKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLinkEntity() when $default != null:
return $default(_that.type,_that.url,_that.labelKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SocialLinkType type,  String url,  String labelKey)  $default,) {final _that = this;
switch (_that) {
case _SocialLinkEntity():
return $default(_that.type,_that.url,_that.labelKey);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SocialLinkType type,  String url,  String labelKey)?  $default,) {final _that = this;
switch (_that) {
case _SocialLinkEntity() when $default != null:
return $default(_that.type,_that.url,_that.labelKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLinkEntity implements SocialLinkEntity {
  const _SocialLinkEntity({required this.type, required this.url, required this.labelKey});
  factory _SocialLinkEntity.fromJson(Map<String, dynamic> json) => _$SocialLinkEntityFromJson(json);

@override final  SocialLinkType type;
@override final  String url;
@override final  String labelKey;

/// Create a copy of SocialLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLinkEntityCopyWith<_SocialLinkEntity> get copyWith => __$SocialLinkEntityCopyWithImpl<_SocialLinkEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLinkEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLinkEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.labelKey, labelKey) || other.labelKey == labelKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url,labelKey);

@override
String toString() {
  return 'SocialLinkEntity(type: $type, url: $url, labelKey: $labelKey)';
}


}

/// @nodoc
abstract mixin class _$SocialLinkEntityCopyWith<$Res> implements $SocialLinkEntityCopyWith<$Res> {
  factory _$SocialLinkEntityCopyWith(_SocialLinkEntity value, $Res Function(_SocialLinkEntity) _then) = __$SocialLinkEntityCopyWithImpl;
@override @useResult
$Res call({
 SocialLinkType type, String url, String labelKey
});




}
/// @nodoc
class __$SocialLinkEntityCopyWithImpl<$Res>
    implements _$SocialLinkEntityCopyWith<$Res> {
  __$SocialLinkEntityCopyWithImpl(this._self, this._then);

  final _SocialLinkEntity _self;
  final $Res Function(_SocialLinkEntity) _then;

/// Create a copy of SocialLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = null,Object? labelKey = null,}) {
  return _then(_SocialLinkEntity(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SocialLinkType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,labelKey: null == labelKey ? _self.labelKey : labelKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
