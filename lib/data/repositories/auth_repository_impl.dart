import 'package:dartz/dartz.dart';
import 'package:mytodo_bloc/data/datasources/auth_remote_datasource.dart';
import '../../domain/failure/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> signIn(
    String email,
    String password,
  ) async {
    return await authRemoteDataSource.signIn(email, password);
  }

  @override
  Future<Either<Failure, UserModel>> register(
    String fullName,
    String email,
    String password,
  ) async {
    return await authRemoteDataSource.register(fullName, email, password);
  }

  @override
  Future<Either<Failure, UserModel>> googleSignIn() async {
    return await authRemoteDataSource.googleSignIn();
  }
}
