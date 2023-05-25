import 'package:schedule/domain/auth/password.dart';
import 'package:schedule/domain/auth/Email.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_form.freezed.dart';

@freezed
class RegistrationForm with _$RegistrationForm {
  const factory RegistrationForm({
    required Email email,
    required Password password,
    required String firstName,
    required String lastName,
  }) = _RegisterForm;
}
