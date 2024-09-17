part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class SignInLoading extends AuthState {}

class SignInSuccess extends AuthState {}

class SignInFailure extends AuthState {
  final String message;

  SignInFailure({
    required this.message,
  });
}

class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class ForgotPasswordFailure extends AuthState {
  final String message;

  ForgotPasswordFailure({
    required this.message,
  });
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String message;

  RegisterFailure({
    required this.message,
  });
}

class GoogleSignInLoading extends AuthState {}

class GoogleSignInSuccess extends AuthState {}

class GoogleSignInFailure extends AuthState {
  final String message;

  GoogleSignInFailure({
    required this.message,
  });
}

class AuthBack extends AuthState {}

class SignInShowPasswordToggled extends AuthState {
  final bool showPassword;

  SignInShowPasswordToggled({required this.showPassword});
}

class RegisterShowPasswordToggled extends AuthState {
  final bool showPassword;

  RegisterShowPasswordToggled({required this.showPassword});
}
