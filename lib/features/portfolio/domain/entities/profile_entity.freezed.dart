// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileEntity {

 String get name; String get monogram; List<String> get roleTitles; String get summaryKey; String get location; String get email; String get phone; String get phoneLink; List<StatEntity> get stats;
/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEntityCopyWith<ProfileEntity> get copyWith => _$ProfileEntityCopyWithImpl<ProfileEntity>(this as ProfileEntity, _$identity);

  /// Serializes this ProfileEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.monogram, monogram) || other.monogram == monogram)&&const DeepCollectionEquality().equals(other.roleTitles, roleTitles)&&(identical(other.summaryKey, summaryKey) || other.summaryKey == summaryKey)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phoneLink, phoneLink) || other.phoneLink == phoneLink)&&const DeepCollectionEquality().equals(other.stats, stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,monogram,const DeepCollectionEquality().hash(roleTitles),summaryKey,location,email,phone,phoneLink,const DeepCollectionEquality().hash(stats));

@override
String toString() {
  return 'ProfileEntity(name: $name, monogram: $monogram, roleTitles: $roleTitles, summaryKey: $summaryKey, location: $location, email: $email, phone: $phone, phoneLink: $phoneLink, stats: $stats)';
}


}

/// @nodoc
abstract mixin class $ProfileEntityCopyWith<$Res>  {
  factory $ProfileEntityCopyWith(ProfileEntity value, $Res Function(ProfileEntity) _then) = _$ProfileEntityCopyWithImpl;
@useResult
$Res call({
 String name, String monogram, List<String> roleTitles, String summaryKey, String location, String email, String phone, String phoneLink, List<StatEntity> stats
});




}
/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._self, this._then);

  final ProfileEntity _self;
  final $Res Function(ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? monogram = null,Object? roleTitles = null,Object? summaryKey = null,Object? location = null,Object? email = null,Object? phone = null,Object? phoneLink = null,Object? stats = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,monogram: null == monogram ? _self.monogram : monogram // ignore: cast_nullable_to_non_nullable
as String,roleTitles: null == roleTitles ? _self.roleTitles : roleTitles // ignore: cast_nullable_to_non_nullable
as List<String>,summaryKey: null == summaryKey ? _self.summaryKey : summaryKey // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneLink: null == phoneLink ? _self.phoneLink : phoneLink // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileEntity].
extension ProfileEntityPatterns on ProfileEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String monogram,  List<String> roleTitles,  String summaryKey,  String location,  String email,  String phone,  String phoneLink,  List<StatEntity> stats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.name,_that.monogram,_that.roleTitles,_that.summaryKey,_that.location,_that.email,_that.phone,_that.phoneLink,_that.stats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String monogram,  List<String> roleTitles,  String summaryKey,  String location,  String email,  String phone,  String phoneLink,  List<StatEntity> stats)  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity():
return $default(_that.name,_that.monogram,_that.roleTitles,_that.summaryKey,_that.location,_that.email,_that.phone,_that.phoneLink,_that.stats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String monogram,  List<String> roleTitles,  String summaryKey,  String location,  String email,  String phone,  String phoneLink,  List<StatEntity> stats)?  $default,) {final _that = this;
switch (_that) {
case _ProfileEntity() when $default != null:
return $default(_that.name,_that.monogram,_that.roleTitles,_that.summaryKey,_that.location,_that.email,_that.phone,_that.phoneLink,_that.stats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileEntity implements ProfileEntity {
  const _ProfileEntity({required this.name, required this.monogram, final  List<String> roleTitles = const [], required this.summaryKey, required this.location, required this.email, required this.phone, required this.phoneLink, final  List<StatEntity> stats = const []}): _roleTitles = roleTitles,_stats = stats;
  factory _ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);

@override final  String name;
@override final  String monogram;
 final  List<String> _roleTitles;
@override@JsonKey() List<String> get roleTitles {
  if (_roleTitles is EqualUnmodifiableListView) return _roleTitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roleTitles);
}

@override final  String summaryKey;
@override final  String location;
@override final  String email;
@override final  String phone;
@override final  String phoneLink;
 final  List<StatEntity> _stats;
@override@JsonKey() List<StatEntity> get stats {
  if (_stats is EqualUnmodifiableListView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stats);
}


/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileEntityCopyWith<_ProfileEntity> get copyWith => __$ProfileEntityCopyWithImpl<_ProfileEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileEntity&&(identical(other.name, name) || other.name == name)&&(identical(other.monogram, monogram) || other.monogram == monogram)&&const DeepCollectionEquality().equals(other._roleTitles, _roleTitles)&&(identical(other.summaryKey, summaryKey) || other.summaryKey == summaryKey)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phoneLink, phoneLink) || other.phoneLink == phoneLink)&&const DeepCollectionEquality().equals(other._stats, _stats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,monogram,const DeepCollectionEquality().hash(_roleTitles),summaryKey,location,email,phone,phoneLink,const DeepCollectionEquality().hash(_stats));

@override
String toString() {
  return 'ProfileEntity(name: $name, monogram: $monogram, roleTitles: $roleTitles, summaryKey: $summaryKey, location: $location, email: $email, phone: $phone, phoneLink: $phoneLink, stats: $stats)';
}


}

/// @nodoc
abstract mixin class _$ProfileEntityCopyWith<$Res> implements $ProfileEntityCopyWith<$Res> {
  factory _$ProfileEntityCopyWith(_ProfileEntity value, $Res Function(_ProfileEntity) _then) = __$ProfileEntityCopyWithImpl;
@override @useResult
$Res call({
 String name, String monogram, List<String> roleTitles, String summaryKey, String location, String email, String phone, String phoneLink, List<StatEntity> stats
});




}
/// @nodoc
class __$ProfileEntityCopyWithImpl<$Res>
    implements _$ProfileEntityCopyWith<$Res> {
  __$ProfileEntityCopyWithImpl(this._self, this._then);

  final _ProfileEntity _self;
  final $Res Function(_ProfileEntity) _then;

/// Create a copy of ProfileEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? monogram = null,Object? roleTitles = null,Object? summaryKey = null,Object? location = null,Object? email = null,Object? phone = null,Object? phoneLink = null,Object? stats = null,}) {
  return _then(_ProfileEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,monogram: null == monogram ? _self.monogram : monogram // ignore: cast_nullable_to_non_nullable
as String,roleTitles: null == roleTitles ? _self._roleTitles : roleTitles // ignore: cast_nullable_to_non_nullable
as List<String>,summaryKey: null == summaryKey ? _self.summaryKey : summaryKey // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneLink: null == phoneLink ? _self.phoneLink : phoneLink // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as List<StatEntity>,
  ));
}


}

// dart format on
