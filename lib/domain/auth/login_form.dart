import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:schedule/domain/auth/email.dart';
import 'package:schedule/domain/auth/password.dart';

part 'login_form.freezed.dart';

@freezed
class LoginForm with _$LoginForm {
  const factory LoginForm({
    required Email userName,
    required Password password,
  }) = _LoginForm;
}
