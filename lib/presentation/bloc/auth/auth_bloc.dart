import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_bloc/data/datasources/auth_remote_datasource.dart';
import 'package:mytodo_bloc/data/repositories/auth_repository_impl.dart';
import 'package:mytodo_bloc/domain/entities/user_entity.dart';
import 'package:mytodo_bloc/domain/usecases/auth_usecases.dart';
import 'package:mytodo_bloc/main.dart';
import '../../../domain/failure/failure.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool _signInShowPassword = true;
  bool _registerShowPassword = true;

  AuthBloc() : super(AuthInitial()) {
    on<SignInRequest>(_signIn);
    on<RegisterRequest>(_register);
    on<AuthBackPressed>(_back);
    on<GoogleSignInRequested>(_googleSignIn);
    on<SignInToggleShowPassword>(_signInTogglePassword);
    on<RegisterToggleShowPassword>(_registerTogglePassword);
  }

  void _signInTogglePassword(
      SignInToggleShowPassword event, Emitter<AuthState> emit) {
    _signInShowPassword = !_signInShowPassword;
    emit(SignInShowPasswordToggled(showPassword: _signInShowPassword));
  }

  void _registerTogglePassword(
      RegisterToggleShowPassword event, Emitter<AuthState> emit) {
    _registerShowPassword = !_registerShowPassword;
    emit(RegisterShowPasswordToggled(showPassword: _registerShowPassword));
  }

  void _back(AuthBackPressed event, Emitter<AuthState> emit) {
    return emit(AuthBack());
  }

  Future<void> _signIn(
    SignInRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(SignInLoading());
    final Either<Failure, UserEntity> result = await SignInUseCase(
      AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSource(),
      ),
    ).call(
      event.email,
      event.password,
    );
    result.fold(
      (failure) {
        return emit(SignInFailure(message: failure.message));
      },
      (user) {
        signInCheck!.setString('signedIn', 'true');
        return emit(SignInSuccess());
      },
    );
  }

  Future<void> _register(
    RegisterRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(RegisterLoading());
    final Either<Failure, UserEntity> result = await RegisterUseCase(
      AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSource(),
      ),
    ).call(
      event.fullName,
      event.email,
      event.password,
    );

    result.fold(
      (failure) {
        return emit(RegisterFailure(message: failure.message));
      },
      (user) {
        signInCheck!.setString('signedIn', 'true');
        return emit(RegisterSuccess());
      },
    );
  }

  Future<void> _googleSignIn(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(GoogleSignInLoading());

    final Either<Failure, UserEntity> result = await GoogleSignInUseCase(
      AuthRepositoryImpl(
        authRemoteDataSource: AuthRemoteDataSource(),
      ),
    ).call();

    result.fold(
      (failure) => emit(GoogleSignInFailure(message: failure.message)),
      (success) => emit(GoogleSignInSuccess()),
    );
  }
}
