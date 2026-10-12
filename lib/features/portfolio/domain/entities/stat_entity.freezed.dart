// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatEntity {

 String get labelKey; int get value; String get suffix;
/// Create a copy of StatEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatEntityCopyWith<StatEntity> get copyWith => _$StatEntityCopyWithImpl<StatEntity>(this as StatEntity, _$identity);

  /// Serializes this StatEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatEntity&&(identical(other.labelKey, labelKey) || other.labelKey == labelKey)&&(identical(other.value, value) || other.value == value)&&(identical(other.suffix, suffix) || other.suffix == suffix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelKey,value,suffix);

@override
String toString() {
  return 'StatEntity(labelKey: $labelKey, value: $value, suffix: $suffix)';
}


}

/// @nodoc
abstract mixin class $StatEntityCopyWith<$Res>  {
  factory $StatEntityCopyWith(StatEntity value, $Res Function(StatEntity) _then) = _$StatEntityCopyWithImpl;
@useResult
$Res call({
 String labelKey, int value, String suffix
});




}
/// @nodoc
class _$StatEntityCopyWithImpl<$Res>
    implements $StatEntityCopyWith<$Res> {
  _$StatEntityCopyWithImpl(this._self, this._then);

  final StatEntity _self;
  final $Res Function(StatEntity) _then;

/// Create a copy of StatEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? labelKey = null,Object? value = null,Object? suffix = null,}) {
  return _then(_self.copyWith(
labelKey: null == labelKey ? _self.labelKey : labelKey // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,suffix: null == suffix ? _self.suffix : suffix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StatEntity].
extension StatEntityPatterns on StatEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatEntity value)  $default,){
final _that = this;
switch (_that) {
case _StatEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatEntity value)?  $default,){
final _that = this;
switch (_that) {
case _StatEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String labelKey,  int value,  String suffix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatEntity() when $default != null:
return $default(_that.labelKey,_that.value,_that.suffix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String labelKey,  int value,  String suffix)  $default,) {final _that = this;
switch (_that) {
case _StatEntity():
return $default(_that.labelKey,_that.value,_that.suffix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String labelKey,  int value,  String suffix)?  $default,) {final _that = this;
switch (_that) {
case _StatEntity() when $default != null:
return $default(_that.labelKey,_that.value,_that.suffix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatEntity implements StatEntity {
  const _StatEntity({required this.labelKey, required this.value, this.suffix = '+'});
  factory _StatEntity.fromJson(Map<String, dynamic> json) => _$StatEntityFromJson(json);

@override final  String labelKey;
@override final  int value;
@override@JsonKey() final  String suffix;

/// Create a copy of StatEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatEntityCopyWith<_StatEntity> get copyWith => __$StatEntityCopyWithImpl<_StatEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatEntity&&(identical(other.labelKey, labelKey) || other.labelKey == labelKey)&&(identical(other.value, value) || other.value == value)&&(identical(other.suffix, suffix) || other.suffix == suffix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,labelKey,value,suffix);

@override
String toString() {
  return 'StatEntity(labelKey: $labelKey, value: $value, suffix: $suffix)';
}


}

/// @nodoc
abstract mixin class _$StatEntityCopyWith<$Res> implements $StatEntityCopyWith<$Res> {
  factory _$StatEntityCopyWith(_StatEntity value, $Res Function(_StatEntity) _then) = __$StatEntityCopyWithImpl;
@override @useResult
$Res call({
 String labelKey, int value, String suffix
});




}
/// @nodoc
class __$StatEntityCopyWithImpl<$Res>
    implements _$StatEntityCopyWith<$Res> {
  __$StatEntityCopyWithImpl(this._self, this._then);

  final _StatEntity _self;
  final $Res Function(_StatEntity) _then;

/// Create a copy of StatEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? labelKey = null,Object? value = null,Object? suffix = null,}) {
  return _then(_StatEntity(
labelKey: null == labelKey ? _self.labelKey : labelKey // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,suffix: null == suffix ? _self.suffix : suffix // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
