import 'package:dartz/dartz.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:mytodo_bloc/domain/failure/failure.dart';
import 'package:mytodo_bloc/domain/repositories/app_repository.dart';


class FetchTasksUseCase {
  final AppRepository appRepository;

  FetchTasksUseCase(this.appRepository);

  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await appRepository.fetchTasks();
  }
}

class AddTaskUseCase {
  final AppRepository appRepository;

  AddTaskUseCase(this.appRepository);

  Future<Either<Failure, TaskEntity>> call(
    String title,
    String body,
    bool prioritized,
    String status,
    DateTime dateTime,
  ) async {
    return await appRepository.addTask(
      title,
      body,
      prioritized,
      status,
      dateTime,
    );
  }
}

class ChangeTaskStatusUseCase {
  final AppRepository appRepository;

  ChangeTaskStatusUseCase(this.appRepository);

  Future<Either<Failure, void>> call(
    String status,
    TaskEntity task,
  ) async {
    return await appRepository.changeTaskStatus(
      status,
      task,
    );
  }
}

class ChangeTaskPriorityUseCase {
  final AppRepository appRepository;

  ChangeTaskPriorityUseCase(this.appRepository);

  Future<Either<Failure, void>> call(
    bool prioritized,
    TaskEntity task,
  ) async {
    return await appRepository.changeTaskPriority(
      prioritized,
      task,
    );
  }
}

class UpdateTaskUseCase {
  final AppRepository appRepository;

  UpdateTaskUseCase(this.appRepository);

  Future<Either<Failure, void>> call(
    TaskEntity task,
  ) async {
    return await appRepository.updateTask(task);
  }
}

class DeleteTaskUseCase {
  final AppRepository appRepository;

  DeleteTaskUseCase(this.appRepository);

  Future<Either<Failure, void>> call(
    TaskEntity task,
  ) async {
    return await appRepository.deleteTask(task);
  }
}

class SignOutUseCase {
  final AppRepository appRepository;

  SignOutUseCase(this.appRepository);

  Future<Either<Failure, void>> call() async {
    return await appRepository.signOut();
  }
}