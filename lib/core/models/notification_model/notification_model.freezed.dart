// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) {
  return _NotificationModel.fromJson(json);
}

/// @nodoc
class _$NotificationModelTearOff {
  const _$NotificationModelTearOff();

  _NotificationModel call(
      {String? id,
      String? title,
      String? body,
      String? notificationType,
      String? userNotifying,
      String userCategory = 'all'}) {
    return _NotificationModel(
      id: id,
      title: title,
      body: body,
      notificationType: notificationType,
      userNotifying: userNotifying,
      userCategory: userCategory,
    );
  }

  NotificationModel fromJson(Map<String, Object?> json) {
    return NotificationModel.fromJson(json);
  }
}

/// @nodoc
const $NotificationModel = _$NotificationModelTearOff();

/// @nodoc
mixin _$NotificationModel {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  String? get notificationType => throw _privateConstructorUsedError;
  String? get userNotifying => throw _privateConstructorUsedError;
  String get userCategory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationModelCopyWith<NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationModelCopyWith<$Res> {
  factory $NotificationModelCopyWith(
          NotificationModel value, $Res Function(NotificationModel) then) =
      _$NotificationModelCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? title,
      String? body,
      String? notificationType,
      String? userNotifying,
      String userCategory});
}

/// @nodoc
class _$NotificationModelCopyWithImpl<$Res>
    implements $NotificationModelCopyWith<$Res> {
  _$NotificationModelCopyWithImpl(this._value, this._then);

  final NotificationModel _value;
  // ignore: unused_field
  final $Res Function(NotificationModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? notificationType = freezed,
    Object? userNotifying = freezed,
    Object? userCategory = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: notificationType == freezed
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      userNotifying: userNotifying == freezed
          ? _value.userNotifying
          : userNotifying // ignore: cast_nullable_to_non_nullable
              as String?,
      userCategory: userCategory == freezed
          ? _value.userCategory
          : userCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$NotificationModelCopyWith<$Res>
    implements $NotificationModelCopyWith<$Res> {
  factory _$NotificationModelCopyWith(
          _NotificationModel value, $Res Function(_NotificationModel) then) =
      __$NotificationModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? title,
      String? body,
      String? notificationType,
      String? userNotifying,
      String userCategory});
}

/// @nodoc
class __$NotificationModelCopyWithImpl<$Res>
    extends _$NotificationModelCopyWithImpl<$Res>
    implements _$NotificationModelCopyWith<$Res> {
  __$NotificationModelCopyWithImpl(
      _NotificationModel _value, $Res Function(_NotificationModel) _then)
      : super(_value, (v) => _then(v as _NotificationModel));

  @override
  _NotificationModel get _value => super._value as _NotificationModel;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? body = freezed,
    Object? notificationType = freezed,
    Object? userNotifying = freezed,
    Object? userCategory = freezed,
  }) {
    return _then(_NotificationModel(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: body == freezed
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: notificationType == freezed
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      userNotifying: userNotifying == freezed
          ? _value.userNotifying
          : userNotifying // ignore: cast_nullable_to_non_nullable
              as String?,
      userCategory: userCategory == freezed
          ? _value.userCategory
          : userCategory // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_NotificationModel extends _NotificationModel
    with DiagnosticableTreeMixin {
  const _$_NotificationModel(
      {this.id,
      this.title,
      this.body,
      this.notificationType,
      this.userNotifying,
      this.userCategory = 'all'})
      : super._();

  factory _$_NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationModelFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final String? notificationType;
  @override
  final String? userNotifying;
  @JsonKey()
  @override
  final String userCategory;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NotificationModel(id: $id, title: $title, body: $body, notificationType: $notificationType, userNotifying: $userNotifying, userCategory: $userCategory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NotificationModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('notificationType', notificationType))
      ..add(DiagnosticsProperty('userNotifying', userNotifying))
      ..add(DiagnosticsProperty('userCategory', userCategory));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotificationModel &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.body, body) &&
            const DeepCollectionEquality()
                .equals(other.notificationType, notificationType) &&
            const DeepCollectionEquality()
                .equals(other.userNotifying, userNotifying) &&
            const DeepCollectionEquality()
                .equals(other.userCategory, userCategory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(body),
      const DeepCollectionEquality().hash(notificationType),
      const DeepCollectionEquality().hash(userNotifying),
      const DeepCollectionEquality().hash(userCategory));

  @JsonKey(ignore: true)
  @override
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      __$NotificationModelCopyWithImpl<_NotificationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationModelToJson(this);
  }
}

abstract class _NotificationModel extends NotificationModel {
  const factory _NotificationModel(
      {String? id,
      String? title,
      String? body,
      String? notificationType,
      String? userNotifying,
      String userCategory}) = _$_NotificationModel;
  const _NotificationModel._() : super._();

  factory _NotificationModel.fromJson(Map<String, dynamic> json) =
      _$_NotificationModel.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get body;
  @override
  String? get notificationType;
  @override
  String? get userNotifying;
  @override
  String get userCategory;
  @override
  @JsonKey(ignore: true)
  _$NotificationModelCopyWith<_NotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
