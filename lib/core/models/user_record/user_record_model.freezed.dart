// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_record_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserRecord _$UserRecordFromJson(Map<String, dynamic> json) {
  return _UserRecord.fromJson(json);
}

/// @nodoc
class _$UserRecordTearOff {
  const _$UserRecordTearOff();

  _UserRecord call({required String id, String? businessName, String? role}) {
    return _UserRecord(
      id: id,
      businessName: businessName,
      role: role,
    );
  }

  UserRecord fromJson(Map<String, Object?> json) {
    return UserRecord.fromJson(json);
  }
}

/// @nodoc
const $UserRecord = _$UserRecordTearOff();

/// @nodoc
mixin _$UserRecord {
  String get id => throw _privateConstructorUsedError;
  String? get businessName => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserRecordCopyWith<UserRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRecordCopyWith<$Res> {
  factory $UserRecordCopyWith(
          UserRecord value, $Res Function(UserRecord) then) =
      _$UserRecordCopyWithImpl<$Res>;
  $Res call({String id, String? businessName, String? role});
}

/// @nodoc
class _$UserRecordCopyWithImpl<$Res> implements $UserRecordCopyWith<$Res> {
  _$UserRecordCopyWithImpl(this._value, this._then);

  final UserRecord _value;
  // ignore: unused_field
  final $Res Function(UserRecord) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? businessName = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: businessName == freezed
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UserRecordCopyWith<$Res> implements $UserRecordCopyWith<$Res> {
  factory _$UserRecordCopyWith(
          _UserRecord value, $Res Function(_UserRecord) then) =
      __$UserRecordCopyWithImpl<$Res>;
  @override
  $Res call({String id, String? businessName, String? role});
}

/// @nodoc
class __$UserRecordCopyWithImpl<$Res> extends _$UserRecordCopyWithImpl<$Res>
    implements _$UserRecordCopyWith<$Res> {
  __$UserRecordCopyWithImpl(
      _UserRecord _value, $Res Function(_UserRecord) _then)
      : super(_value, (v) => _then(v as _UserRecord));

  @override
  _UserRecord get _value => super._value as _UserRecord;

  @override
  $Res call({
    Object? id = freezed,
    Object? businessName = freezed,
    Object? role = freezed,
  }) {
    return _then(_UserRecord(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      businessName: businessName == freezed
          ? _value.businessName
          : businessName // ignore: cast_nullable_to_non_nullable
              as String?,
      role: role == freezed
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserRecord extends _UserRecord with DiagnosticableTreeMixin {
  _$_UserRecord({required this.id, this.businessName, this.role}) : super._();

  factory _$_UserRecord.fromJson(Map<String, dynamic> json) =>
      _$$_UserRecordFromJson(json);

  @override
  final String id;
  @override
  final String? businessName;
  @override
  final String? role;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserRecord(id: $id, businessName: $businessName, role: $role)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserRecord'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('businessName', businessName))
      ..add(DiagnosticsProperty('role', role));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserRecord &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.businessName, businessName) &&
            const DeepCollectionEquality().equals(other.role, role));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(businessName),
      const DeepCollectionEquality().hash(role));

  @JsonKey(ignore: true)
  @override
  _$UserRecordCopyWith<_UserRecord> get copyWith =>
      __$UserRecordCopyWithImpl<_UserRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserRecordToJson(this);
  }
}

abstract class _UserRecord extends UserRecord {
  factory _UserRecord(
      {required String id, String? businessName, String? role}) = _$_UserRecord;
  _UserRecord._() : super._();

  factory _UserRecord.fromJson(Map<String, dynamic> json) =
      _$_UserRecord.fromJson;

  @override
  String get id;
  @override
  String? get businessName;
  @override
  String? get role;
  @override
  @JsonKey(ignore: true)
  _$UserRecordCopyWith<_UserRecord> get copyWith =>
      throw _privateConstructorUsedError;
}
