// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skill_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SkillEntity {

 String get name;
/// Create a copy of SkillEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillEntityCopyWith<SkillEntity> get copyWith => _$SkillEntityCopyWithImpl<SkillEntity>(this as SkillEntity, _$identity);

  /// Serializes this SkillEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillEntity&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SkillEntity(name: $name)';
}


}

/// @nodoc
abstract mixin class $SkillEntityCopyWith<$Res>  {
  factory $SkillEntityCopyWith(SkillEntity value, $Res Function(SkillEntity) _then) = _$SkillEntityCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$SkillEntityCopyWithImpl<$Res>
    implements $SkillEntityCopyWith<$Res> {
  _$SkillEntityCopyWithImpl(this._self, this._then);

  final SkillEntity _self;
  final $Res Function(SkillEntity) _then;

/// Create a copy of SkillEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillEntity].
extension SkillEntityPatterns on SkillEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillEntity value)  $default,){
final _that = this;
switch (_that) {
case _SkillEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SkillEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillEntity() when $default != null:
return $default(_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name)  $default,) {final _that = this;
switch (_that) {
case _SkillEntity():
return $default(_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name)?  $default,) {final _that = this;
switch (_that) {
case _SkillEntity() when $default != null:
return $default(_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillEntity implements SkillEntity {
  const _SkillEntity({required this.name});
  factory _SkillEntity.fromJson(Map<String, dynamic> json) => _$SkillEntityFromJson(json);

@override final  String name;

/// Create a copy of SkillEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillEntityCopyWith<_SkillEntity> get copyWith => __$SkillEntityCopyWithImpl<_SkillEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillEntity&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'SkillEntity(name: $name)';
}


}

/// @nodoc
abstract mixin class _$SkillEntityCopyWith<$Res> implements $SkillEntityCopyWith<$Res> {
  factory _$SkillEntityCopyWith(_SkillEntity value, $Res Function(_SkillEntity) _then) = __$SkillEntityCopyWithImpl;
@override @useResult
$Res call({
 String name
});




}
/// @nodoc
class __$SkillEntityCopyWithImpl<$Res>
    implements _$SkillEntityCopyWith<$Res> {
  __$SkillEntityCopyWithImpl(this._self, this._then);

  final _SkillEntity _self;
  final $Res Function(_SkillEntity) _then;

/// Create a copy of SkillEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_SkillEntity(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SkillGroupEntity {

 String get id; String get groupKey; String get iconKey; List<SkillEntity> get items;
/// Create a copy of SkillGroupEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillGroupEntityCopyWith<SkillGroupEntity> get copyWith => _$SkillGroupEntityCopyWithImpl<SkillGroupEntity>(this as SkillGroupEntity, _$identity);

  /// Serializes this SkillGroupEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillGroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.groupKey, groupKey) || other.groupKey == groupKey)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupKey,iconKey,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SkillGroupEntity(id: $id, groupKey: $groupKey, iconKey: $iconKey, items: $items)';
}


}

/// @nodoc
abstract mixin class $SkillGroupEntityCopyWith<$Res>  {
  factory $SkillGroupEntityCopyWith(SkillGroupEntity value, $Res Function(SkillGroupEntity) _then) = _$SkillGroupEntityCopyWithImpl;
@useResult
$Res call({
 String id, String groupKey, String iconKey, List<SkillEntity> items
});




}
/// @nodoc
class _$SkillGroupEntityCopyWithImpl<$Res>
    implements $SkillGroupEntityCopyWith<$Res> {
  _$SkillGroupEntityCopyWithImpl(this._self, this._then);

  final SkillGroupEntity _self;
  final $Res Function(SkillGroupEntity) _then;

/// Create a copy of SkillGroupEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupKey = null,Object? iconKey = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupKey: null == groupKey ? _self.groupKey : groupKey // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SkillEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillGroupEntity].
extension SkillGroupEntityPatterns on SkillGroupEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillGroupEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillGroupEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillGroupEntity value)  $default,){
final _that = this;
switch (_that) {
case _SkillGroupEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillGroupEntity value)?  $default,){
final _that = this;
switch (_that) {
case _SkillGroupEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String groupKey,  String iconKey,  List<SkillEntity> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillGroupEntity() when $default != null:
return $default(_that.id,_that.groupKey,_that.iconKey,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String groupKey,  String iconKey,  List<SkillEntity> items)  $default,) {final _that = this;
switch (_that) {
case _SkillGroupEntity():
return $default(_that.id,_that.groupKey,_that.iconKey,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String groupKey,  String iconKey,  List<SkillEntity> items)?  $default,) {final _that = this;
switch (_that) {
case _SkillGroupEntity() when $default != null:
return $default(_that.id,_that.groupKey,_that.iconKey,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillGroupEntity implements SkillGroupEntity {
  const _SkillGroupEntity({required this.id, required this.groupKey, required this.iconKey, final  List<SkillEntity> items = const []}): _items = items;
  factory _SkillGroupEntity.fromJson(Map<String, dynamic> json) => _$SkillGroupEntityFromJson(json);

@override final  String id;
@override final  String groupKey;
@override final  String iconKey;
 final  List<SkillEntity> _items;
@override@JsonKey() List<SkillEntity> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SkillGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillGroupEntityCopyWith<_SkillGroupEntity> get copyWith => __$SkillGroupEntityCopyWithImpl<_SkillGroupEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillGroupEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillGroupEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.groupKey, groupKey) || other.groupKey == groupKey)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,groupKey,iconKey,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SkillGroupEntity(id: $id, groupKey: $groupKey, iconKey: $iconKey, items: $items)';
}


}

/// @nodoc
abstract mixin class _$SkillGroupEntityCopyWith<$Res> implements $SkillGroupEntityCopyWith<$Res> {
  factory _$SkillGroupEntityCopyWith(_SkillGroupEntity value, $Res Function(_SkillGroupEntity) _then) = __$SkillGroupEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String groupKey, String iconKey, List<SkillEntity> items
});




}
/// @nodoc
class __$SkillGroupEntityCopyWithImpl<$Res>
    implements _$SkillGroupEntityCopyWith<$Res> {
  __$SkillGroupEntityCopyWithImpl(this._self, this._then);

  final _SkillGroupEntity _self;
  final $Res Function(_SkillGroupEntity) _then;

/// Create a copy of SkillGroupEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupKey = null,Object? iconKey = null,Object? items = null,}) {
  return _then(_SkillGroupEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupKey: null == groupKey ? _self.groupKey : groupKey // ignore: cast_nullable_to_non_nullable
as String,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SkillEntity>,
  ));
}


}

// dart format on
