import 'package:dartz/dartz.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:mytodo_bloc/domain/failure/failure.dart';

abstract class AppRepository {
  Future<Either<Failure, List<TaskEntity>>> fetchTasks();

  Future<Either<Failure, TaskEntity>> addTask(
    String title,
    String body,
    bool prioritized,
    String status,
    DateTime dateTime,
  );

  Future<Either<Failure, void>> changeTaskStatus(
    String status,
    TaskEntity task,
  );

  Future<Either<Failure, void>> changeTaskPriority(
    bool prioritized,
    TaskEntity task,
  );

  Future<Either<Failure, void>> updateTask(TaskEntity task);

  Future<Either<Failure, void>> deleteTask(TaskEntity task);

  Future<Either<Failure, void>> signOut();
}
