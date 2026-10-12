// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProjectLinkEntity {

 ProjectLinkType get type; String get url;
/// Create a copy of ProjectLinkEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectLinkEntityCopyWith<ProjectLinkEntity> get copyWith => _$ProjectLinkEntityCopyWithImpl<ProjectLinkEntity>(this as ProjectLinkEntity, _$identity);

  /// Serializes this ProjectLinkEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectLinkEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'ProjectLinkEntity(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class $ProjectLinkEntityCopyWith<$Res>  {
  factory $ProjectLinkEntityCopyWith(ProjectLinkEntity value, $Res Function(ProjectLinkEntity) _then) = _$ProjectLinkEntityCopyWithImpl;
@useResult
$Res call({
 ProjectLinkType type, String url
});




}
/// @nodoc
class _$ProjectLinkEntityCopyWithImpl<$Res>
    implements $ProjectLinkEntityCopyWith<$Res> {
  _$ProjectLinkEntityCopyWithImpl(this._self, this._then);

  final ProjectLinkEntity _self;
  final $Res Function(ProjectLinkEntity) _then;

/// Create a copy of ProjectLinkEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? url = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProjectLinkType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectLinkEntity].
extension ProjectLinkEntityPatterns on ProjectLinkEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectLinkEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectLinkEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectLinkEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProjectLinkEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectLinkEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectLinkEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProjectLinkType type,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectLinkEntity() when $default != null:
return $default(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProjectLinkType type,  String url)  $default,) {final _that = this;
switch (_that) {
case _ProjectLinkEntity():
return $default(_that.type,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProjectLinkType type,  String url)?  $default,) {final _that = this;
switch (_that) {
case _ProjectLinkEntity() when $default != null:
return $default(_that.type,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectLinkEntity implements ProjectLinkEntity {
  const _ProjectLinkEntity({required this.type, required this.url});
  factory _ProjectLinkEntity.fromJson(Map<String, dynamic> json) => _$ProjectLinkEntityFromJson(json);

@override final  ProjectLinkType type;
@override final  String url;

/// Create a copy of ProjectLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectLinkEntityCopyWith<_ProjectLinkEntity> get copyWith => __$ProjectLinkEntityCopyWithImpl<_ProjectLinkEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectLinkEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectLinkEntity&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url);

@override
String toString() {
  return 'ProjectLinkEntity(type: $type, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ProjectLinkEntityCopyWith<$Res> implements $ProjectLinkEntityCopyWith<$Res> {
  factory _$ProjectLinkEntityCopyWith(_ProjectLinkEntity value, $Res Function(_ProjectLinkEntity) _then) = __$ProjectLinkEntityCopyWithImpl;
@override @useResult
$Res call({
 ProjectLinkType type, String url
});




}
/// @nodoc
class __$ProjectLinkEntityCopyWithImpl<$Res>
    implements _$ProjectLinkEntityCopyWith<$Res> {
  __$ProjectLinkEntityCopyWithImpl(this._self, this._then);

  final _ProjectLinkEntity _self;
  final $Res Function(_ProjectLinkEntity) _then;

/// Create a copy of ProjectLinkEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = null,}) {
  return _then(_ProjectLinkEntity(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ProjectLinkType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProjectEntity {

 String get id; ProjectCategory get category; String get iconKey; String get accentHex; String get titleKey; String get descriptionKey; List<String> get highlights; List<String> get tech; List<ProjectLinkEntity> get links;
/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectEntityCopyWith<ProjectEntity> get copyWith => _$ProjectEntityCopyWithImpl<ProjectEntity>(this as ProjectEntity, _$identity);

  /// Serializes this ProjectEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProjectEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.accentHex, accentHex) || other.accentHex == accentHex)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&const DeepCollectionEquality().equals(other.highlights, highlights)&&const DeepCollectionEquality().equals(other.tech, tech)&&const DeepCollectionEquality().equals(other.links, links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,iconKey,accentHex,titleKey,descriptionKey,const DeepCollectionEquality().hash(highlights),const DeepCollectionEquality().hash(tech),const DeepCollectionEquality().hash(links));

@override
String toString() {
  return 'ProjectEntity(id: $id, category: $category, iconKey: $iconKey, accentHex: $accentHex, titleKey: $titleKey, descriptionKey: $descriptionKey, highlights: $highlights, tech: $tech, links: $links)';
}


}

/// @nodoc
abstract mixin class $ProjectEntityCopyWith<$Res>  {
  factory $ProjectEntityCopyWith(ProjectEntity value, $Res Function(ProjectEntity) _then) = _$ProjectEntityCopyWithImpl;
@useResult
$Res call({
 String id, ProjectCategory category, String iconKey, String accentHex, String titleKey, String descriptionKey, List<String> highlights, List<String> tech, List<ProjectLinkEntity> links
});




}
/// @nodoc
class _$ProjectEntityCopyWithImpl<$Res>
    implements $ProjectEntityCopyWith<$Res> {
  _$ProjectEntityCopyWithImpl(this._self, this._then);

  final ProjectEntity _self;
  final $Res Function(ProjectEntity) _then;

/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? iconKey = null,Object? accentHex = null,Object? titleKey = null,Object? descriptionKey = null,Object? highlights = null,Object? tech = null,Object? links = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProjectCategory,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,accentHex: null == accentHex ? _self.accentHex : accentHex // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,highlights: null == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,tech: null == tech ? _self.tech : tech // ignore: cast_nullable_to_non_nullable
as List<String>,links: null == links ? _self.links : links // ignore: cast_nullable_to_non_nullable
as List<ProjectLinkEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProjectEntity].
extension ProjectEntityPatterns on ProjectEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProjectEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProjectEntity value)  $default,){
final _that = this;
switch (_that) {
case _ProjectEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProjectEntity value)?  $default,){
final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  ProjectCategory category,  String iconKey,  String accentHex,  String titleKey,  String descriptionKey,  List<String> highlights,  List<String> tech,  List<ProjectLinkEntity> links)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
return $default(_that.id,_that.category,_that.iconKey,_that.accentHex,_that.titleKey,_that.descriptionKey,_that.highlights,_that.tech,_that.links);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  ProjectCategory category,  String iconKey,  String accentHex,  String titleKey,  String descriptionKey,  List<String> highlights,  List<String> tech,  List<ProjectLinkEntity> links)  $default,) {final _that = this;
switch (_that) {
case _ProjectEntity():
return $default(_that.id,_that.category,_that.iconKey,_that.accentHex,_that.titleKey,_that.descriptionKey,_that.highlights,_that.tech,_that.links);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  ProjectCategory category,  String iconKey,  String accentHex,  String titleKey,  String descriptionKey,  List<String> highlights,  List<String> tech,  List<ProjectLinkEntity> links)?  $default,) {final _that = this;
switch (_that) {
case _ProjectEntity() when $default != null:
return $default(_that.id,_that.category,_that.iconKey,_that.accentHex,_that.titleKey,_that.descriptionKey,_that.highlights,_that.tech,_that.links);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProjectEntity implements ProjectEntity {
  const _ProjectEntity({required this.id, required this.category, required this.iconKey, required this.accentHex, required this.titleKey, required this.descriptionKey, final  List<String> highlights = const [], final  List<String> tech = const [], final  List<ProjectLinkEntity> links = const []}): _highlights = highlights,_tech = tech,_links = links;
  factory _ProjectEntity.fromJson(Map<String, dynamic> json) => _$ProjectEntityFromJson(json);

@override final  String id;
@override final  ProjectCategory category;
@override final  String iconKey;
@override final  String accentHex;
@override final  String titleKey;
@override final  String descriptionKey;
 final  List<String> _highlights;
@override@JsonKey() List<String> get highlights {
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_highlights);
}

 final  List<String> _tech;
@override@JsonKey() List<String> get tech {
  if (_tech is EqualUnmodifiableListView) return _tech;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tech);
}

 final  List<ProjectLinkEntity> _links;
@override@JsonKey() List<ProjectLinkEntity> get links {
  if (_links is EqualUnmodifiableListView) return _links;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_links);
}


/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectEntityCopyWith<_ProjectEntity> get copyWith => __$ProjectEntityCopyWithImpl<_ProjectEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProjectEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.iconKey, iconKey) || other.iconKey == iconKey)&&(identical(other.accentHex, accentHex) || other.accentHex == accentHex)&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.descriptionKey, descriptionKey) || other.descriptionKey == descriptionKey)&&const DeepCollectionEquality().equals(other._highlights, _highlights)&&const DeepCollectionEquality().equals(other._tech, _tech)&&const DeepCollectionEquality().equals(other._links, _links));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,iconKey,accentHex,titleKey,descriptionKey,const DeepCollectionEquality().hash(_highlights),const DeepCollectionEquality().hash(_tech),const DeepCollectionEquality().hash(_links));

@override
String toString() {
  return 'ProjectEntity(id: $id, category: $category, iconKey: $iconKey, accentHex: $accentHex, titleKey: $titleKey, descriptionKey: $descriptionKey, highlights: $highlights, tech: $tech, links: $links)';
}


}

/// @nodoc
abstract mixin class _$ProjectEntityCopyWith<$Res> implements $ProjectEntityCopyWith<$Res> {
  factory _$ProjectEntityCopyWith(_ProjectEntity value, $Res Function(_ProjectEntity) _then) = __$ProjectEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, ProjectCategory category, String iconKey, String accentHex, String titleKey, String descriptionKey, List<String> highlights, List<String> tech, List<ProjectLinkEntity> links
});




}
/// @nodoc
class __$ProjectEntityCopyWithImpl<$Res>
    implements _$ProjectEntityCopyWith<$Res> {
  __$ProjectEntityCopyWithImpl(this._self, this._then);

  final _ProjectEntity _self;
  final $Res Function(_ProjectEntity) _then;

/// Create a copy of ProjectEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? iconKey = null,Object? accentHex = null,Object? titleKey = null,Object? descriptionKey = null,Object? highlights = null,Object? tech = null,Object? links = null,}) {
  return _then(_ProjectEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ProjectCategory,iconKey: null == iconKey ? _self.iconKey : iconKey // ignore: cast_nullable_to_non_nullable
as String,accentHex: null == accentHex ? _self.accentHex : accentHex // ignore: cast_nullable_to_non_nullable
as String,titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,descriptionKey: null == descriptionKey ? _self.descriptionKey : descriptionKey // ignore: cast_nullable_to_non_nullable
as String,highlights: null == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>,tech: null == tech ? _self._tech : tech // ignore: cast_nullable_to_non_nullable
as List<String>,links: null == links ? _self._links : links // ignore: cast_nullable_to_non_nullable
as List<ProjectLinkEntity>,
  ));
}


}

// dart format on
