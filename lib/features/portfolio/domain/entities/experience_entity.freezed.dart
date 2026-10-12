// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'experience_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExperienceEntity {

 String get id; String get company; String get roleKey; String get periodKey; String get location; String get typeKey; String get iconKey; bool get isEducation; bool get isCurrent; List<String> get highlights;
/// Create a copy of ExperienceEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperienceEntityCopyWith<ExperienceEntity> get copyWith => _$ExperienceEntityCopyWithImpl<ExperienceEntity>(this as ExperienceEntity, _$identity);

  /// Serializes this ExperienceEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExperienceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.company, company) || other.company == company)&&(identical(other.roleKey, roleKey) || other.roleKey == roleKey)&&(identical(other.periodKey, periodKey) || other.periodKey == periodKey)&&(identical(other.location, location) || other.location == location)&&(identical(other.typeKey, typeKey) || other.typeKey == typeKey)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isEducation, isEducation) || other.isEducation == isEducation)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&const DeepCollectionEquality().equals(other.highlights, highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,company,roleKey,periodKey,location,typeKey,iconKey,isEducation,isCurrent,const DeepCollectionEquality().hash(highlights));

@override
String toString() {
  return 'ExperienceEntity(id: $id, company: $company, roleKey: $roleKey, periodKey: $periodKey, location: $location, typeKey: $typeKey, iconKey: $iconKey, isEducation: $isEducation, isCurrent: $isCurrent, highlights: $highlights)';
}


}

/// @nodoc
abstract mixin class $ExperienceEntityCopyWith<$Res>  {
  factory $ExperienceEntityCopyWith(ExperienceEntity value, $Res Function(ExperienceEntity) _then) = _$ExperienceEntityCopyWithImpl;
@useResult
$Res call({
 String id, String company, String roleKey, String periodKey, String location, String typeKey, String iconKey, bool isEducation, bool isCurrent, List<String> highlights
});




}
/// @nodoc
class _$ExperienceEntityCopyWithImpl<$Res>
    implements $ExperienceEntityCopyWith<$Res> {
  _$ExperienceEntityCopyWithImpl(this._self, this._then);

  final ExperienceEntity _self;
  final $Res Function(ExperienceEntity) _then;

/// Create a copy of ExperienceEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? company = null,Object? roleKey = null,Object? periodKey = null,Object? location = null,Object? typeKey = null,Object? iconKey = null,Object? isEducation = null,Object? isCurrent = null,Object? highlights = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,roleKey: null == roleKey ? _self.roleKey : roleKey // ignore: cast_nullable_to_non_nullable
as String,periodKey: null == periodKey ? _self.periodKey : periodKey // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,typeKey: null == typeKey ? _self.typeKey : typeKey // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,isEducation: null == isEducation ? _self.isEducation : isEducation // ignore: cast_nullable_to_non_nullable
as bool,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExperienceEntity].
extension ExperienceEntityPatterns on ExperienceEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExperienceEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExperienceEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExperienceEntity value)  $default,){
final _that = this;
switch (_that) {
case _ExperienceEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExperienceEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ExperienceEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String company,  String roleKey,  String periodKey,  String location,  String typeKey,  String iconKey,  bool isEducation,  bool isCurrent,  List<String> highlights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExperienceEntity() when $default != null:
return $default(_that.id,_that.company,_that.roleKey,_that.periodKey,_that.location,_that.typeKey,_that.iconKey,_that.isEducation,_that.isCurrent,_that.highlights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String company,  String roleKey,  String periodKey,  String location,  String typeKey,  String iconKey,  bool isEducation,  bool isCurrent,  List<String> highlights)  $default,) {final _that = this;
switch (_that) {
case _ExperienceEntity():
return $default(_that.id,_that.company,_that.roleKey,_that.periodKey,_that.location,_that.typeKey,_that.iconKey,_that.isEducation,_that.isCurrent,_that.highlights);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String company,  String roleKey,  String periodKey,  String location,  String typeKey,  String iconKey,  bool isEducation,  bool isCurrent,  List<String> highlights)?  $default,) {final _that = this;
switch (_that) {
case _ExperienceEntity() when $default != null:
return $default(_that.id,_that.company,_that.roleKey,_that.periodKey,_that.location,_that.typeKey,_that.iconKey,_that.isEducation,_that.isCurrent,_that.highlights);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExperienceEntity implements ExperienceEntity {
  const _ExperienceEntity({required this.id, required this.company, required this.roleKey, required this.periodKey, required this.location, required this.typeKey, required this.iconKey, this.isEducation = false, this.isCurrent = false, final  List<String> highlights = const []}): _highlights = highlights;
  factory _ExperienceEntity.fromJson(Map<String, dynamic> json) => _$ExperienceEntityFromJson(json);

@override final  String id;
@override final  String company;
@override final  String roleKey;
@override final  String periodKey;
@override final  String location;
@override final  String typeKey;
@override final  String iconKey;
@override@JsonKey() final  bool isEducation;
@override@JsonKey() final  bool isCurrent;
 final  List<String> _highlights;
@override@JsonKey() List<String> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}


/// Create a copy of ExperienceEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperienceEntityCopyWith<_ExperienceEntity> get copyWith => __$ExperienceEntityCopyWithImpl<_ExperienceEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExperienceEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExperienceEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.company, company) || other.company == company)&&(identical(other.roleKey, roleKey) || other.roleKey == roleKey)&&(identical(other.periodKey, periodKey) || other.periodKey == periodKey)&&(identical(other.location, location) || other.location == location)&&(identical(other.typeKey, typeKey) || other.typeKey == typeKey)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.isEducation, isEducation) || other.isEducation == isEducation)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&const DeepCollectionEquality().equals(other._highlights, _highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,company,roleKey,periodKey,location,typeKey,iconKey,isEducation,isCurrent,const DeepCollectionEquality().hash(_highlights));

@override
String toString() {
  return 'ExperienceEntity(id: $id, company: $company, roleKey: $roleKey, periodKey: $periodKey, location: $location, typeKey: $typeKey, iconKey: $iconKey, isEducation: $isEducation, isCurrent: $isCurrent, highlights: $highlights)';
}


}

/// @nodoc
abstract mixin class _$ExperienceEntityCopyWith<$Res> implements $ExperienceEntityCopyWith<$Res> {
  factory _$ExperienceEntityCopyWith(_ExperienceEntity value, $Res Function(_ExperienceEntity) _then) = __$ExperienceEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String company, String roleKey, String periodKey, String location, String typeKey, String iconKey, bool isEducation, bool isCurrent, List<String> highlights
});




}
/// @nodoc
class __$ExperienceEntityCopyWithImpl<$Res>
    implements _$ExperienceEntityCopyWith<$Res> {
  __$ExperienceEntityCopyWithImpl(this._self, this._then);

  final _ExperienceEntity _self;
  final $Res Function(_ExperienceEntity) _then;

/// Create a copy of ExperienceEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? company = null,Object? roleKey = null,Object? periodKey = null,Object? location = null,Object? typeKey = null,Object? iconKey = null,Object? isEducation = null,Object? isCurrent = null,Object? highlights = null,}) {
  return _then(_ExperienceEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,roleKey: null == roleKey ? _self.roleKey : roleKey // ignore: cast_nullable_to_non_nullable
as String,periodKey: null == periodKey ? _self.periodKey : periodKey // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,typeKey: null == typeKey ? _self.typeKey : typeKey // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,isEducation: null == isEducation ? _self.isEducation : isEducation // ignore: cast_nullable_to_non_nullable
as bool,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
