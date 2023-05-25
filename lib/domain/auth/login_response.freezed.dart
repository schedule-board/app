// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginReponse {
  User get user => throw _privateConstructorUsedError;
  String get jwt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginReponseCopyWith<LoginReponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginReponseCopyWith<$Res> {
  factory $LoginReponseCopyWith(
          LoginReponse value, $Res Function(LoginReponse) then) =
      _$LoginReponseCopyWithImpl<$Res, LoginReponse>;
  @useResult
  $Res call({User user, String jwt});
}

/// @nodoc
class _$LoginReponseCopyWithImpl<$Res, $Val extends LoginReponse>
    implements $LoginReponseCopyWith<$Res> {
  _$LoginReponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? jwt = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginReponseCopyWith<$Res>
    implements $LoginReponseCopyWith<$Res> {
  factory _$$_LoginReponseCopyWith(
          _$_LoginReponse value, $Res Function(_$_LoginReponse) then) =
      __$$_LoginReponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({User user, String jwt});
}

/// @nodoc
class __$$_LoginReponseCopyWithImpl<$Res>
    extends _$LoginReponseCopyWithImpl<$Res, _$_LoginReponse>
    implements _$$_LoginReponseCopyWith<$Res> {
  __$$_LoginReponseCopyWithImpl(
      _$_LoginReponse _value, $Res Function(_$_LoginReponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? jwt = null,
  }) {
    return _then(_$_LoginReponse(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
      jwt: null == jwt
          ? _value.jwt
          : jwt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginReponse implements _LoginReponse {
  const _$_LoginReponse({required this.user, required this.jwt});

  @override
  final User user;
  @override
  final String jwt;

  @override
  String toString() {
    return 'LoginReponse(user: $user, jwt: $jwt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginReponse &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.jwt, jwt) || other.jwt == jwt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, jwt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginReponseCopyWith<_$_LoginReponse> get copyWith =>
      __$$_LoginReponseCopyWithImpl<_$_LoginReponse>(this, _$identity);
}

abstract class _LoginReponse implements LoginReponse {
  const factory _LoginReponse(
      {required final User user, required final String jwt}) = _$_LoginReponse;

  @override
  User get user;
  @override
  String get jwt;
  @override
  @JsonKey(ignore: true)
  _$$_LoginReponseCopyWith<_$_LoginReponse> get copyWith =>
      throw _privateConstructorUsedError;
}
