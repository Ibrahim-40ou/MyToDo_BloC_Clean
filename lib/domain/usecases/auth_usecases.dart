import 'package:dartz/dartz.dart';
import 'package:mytodo_bloc/domain/entities/user_entity.dart';

import '../failure/failure.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await authRepository.signIn(
      email,
      password,
    );
  }
}

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call(
    String fullName,
    String email,
    String password,
  ) async {
    return await authRepository.register(
      fullName,
      email,
      password,
    );
  }
}

class GoogleSignInUseCase {
  final AuthRepository authRepository;

  GoogleSignInUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await authRepository.googleSignIn();
  }
}
