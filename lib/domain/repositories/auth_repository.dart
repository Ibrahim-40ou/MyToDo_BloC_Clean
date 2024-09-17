import 'package:dartz/dartz.dart';

import '../entities/user_entity.dart';
import '../failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signIn(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> register(
    String fullName,
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> googleSignIn();
}
