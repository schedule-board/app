import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_dto.freezed.dart';


@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    @JsonKey(name: 'email') required String email,
    required String firstName,
    required String lastName,
    required String role,
    @JsonKey(name: 'profilePicture') required String profilePictureRelativeUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}