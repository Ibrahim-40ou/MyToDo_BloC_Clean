import 'package:dartz/dartz.dart';
import 'package:mytodo_bloc/data/datasources/app_remote_datasource.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:mytodo_bloc/domain/failure/failure.dart';
import 'package:mytodo_bloc/domain/repositories/app_repository.dart';

class AppRepositoryImpl implements AppRepository {
  final AppRemoteDataSource appRemoteDataSource;

  AppRepositoryImpl({required this.appRemoteDataSource});

  @override
  Future<Either<Failure, List<TaskEntity>>> fetchTasks() async {
    return await appRemoteDataSource.fetchTasks();
  }

  @override
  Future<Either<Failure, TaskEntity>> addTask(
    String title,
    String body,
    bool prioritized,
    String status,
    DateTime dateTime,
  ) async {
    return await appRemoteDataSource.addTask(
      title,
      body,
      prioritized,
      status,
      dateTime,
    );
  }

  @override
  Future<Either<Failure, void>> changeTaskStatus(
    String status,
    TaskEntity task,
  ) async {
    return await appRemoteDataSource.changeTaskStatus(status, task);
  }

  @override
  Future<Either<Failure, void>> changeTaskPriority(
      bool prioritized,
      TaskEntity task,
      ) async {
    return await appRemoteDataSource.changeTaskPriority(prioritized, task);
  }


  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    return await appRemoteDataSource.updateTask(task);
  }

  @override
  Future<Either<Failure, void>> deleteTask(TaskEntity task) async {
    return await appRemoteDataSource.deleteTask(task);
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return await appRemoteDataSource.signOut();
  }
}
