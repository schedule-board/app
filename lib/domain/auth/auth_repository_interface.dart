import 'package:schedule/domain/auth/change_password_form.dart';
import 'package:schedule/domain/auth/login_form.dart';
import 'package:schedule/domain/auth/login_response.dart';
import 'package:schedule/domain/auth/registration_form.dart';
import 'package:schedule/domain/auth/user.dart';
import 'package:schedule/utils/either.dart';


abstract class AuthRepositoryInterface {
  Future<Either<User>> register({required RegistrationForm registerForm});

  Future<Either<LoginReponse>> login({required LoginForm loginForm});

  Future<Either<void>> changePassword(
      {required ChangePasswordForm changePasswordForm});

  Future<String?> getAuthToken();

  Future<void> logout();

  Future<User?> getAuthenticatedUser();

  User? getAuthenticatedUserSync();
}
