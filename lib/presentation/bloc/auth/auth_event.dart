part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignInRequest extends AuthEvent {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });
}

class RegisterRequest extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
  });
}

class AuthBackPressed extends AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class SignInToggleShowPassword extends AuthEvent {}

class RegisterToggleShowPassword extends AuthEvent {}
