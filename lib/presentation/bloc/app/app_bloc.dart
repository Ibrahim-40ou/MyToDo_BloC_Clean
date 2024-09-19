import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mytodo_bloc/core/common_functions.dart';
import 'package:mytodo_bloc/data/datasources/app_remote_datasource.dart';
import 'package:mytodo_bloc/data/repositories/app_repository_impl.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:mytodo_bloc/domain/usecases/app_usecases.dart';
import 'package:mytodo_bloc/main.dart';
import '../../../domain/failure/failure.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  bool _isPrioritized = false;
  DateTime? _selectedDateTime;
  List<TaskEntity> _tasks = [];

  AppBloc() : super(AppInitial()) {
    on<FetchTasks>(_fetchTasks);
    on<AddTaskEvent>(_addTask);
    on<TogglePriority>(_togglePriority);
    on<AppBackPressed>(_back);
    on<PickDateTime>(_pickDateTime);
    on<ChangeTaskStatusEvent>(_changeTaskStatus);
    on<ChangeTaskPriorityEvent>(_changeTaskPriority);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SignOutRequested>(_signOut);
    on<ChangeTheme>(_changeTheme);
    on<LoadTheme>(_loadTheme);
    on<ChangeLanguage>(_changeLanguage);
  }

  void _changeLanguage(ChangeLanguage event, Emitter<AppState> emit) {
    if(event.isArabic) {
      event.context.setLocale(const Locale('ar', 'DZ'));
      arabicCheck!.setBool('isArabic', true);
    } else {
      event.context.setLocale(const Locale('en', 'US'));
      arabicCheck!.setBool('isArabic', false);
    }
    emit(LanguageChanged(isArabic: event.isArabic));
    emit(FetchTasksSuccess(tasks: _tasks));
  }

  void _loadTheme(LoadTheme event, Emitter<AppState> emit) {
    emit(ThemeChanged(isDarkMode: event.isDarkMode));
    emit(FetchTasksSuccess(tasks: _tasks));
  }

  void _changeTheme(ChangeTheme event, Emitter<AppState> emit) {
    darkModeCheck?.setBool('isDarkMode', event.isDarkMode);
    emit(ThemeChanged(isDarkMode: event.isDarkMode));
    emit(FetchTasksSuccess(tasks: _tasks));
  }

  Future<void> _pickDateTime(PickDateTime event, Emitter<AppState> emit) async {
    DateTime? date = await showDatePicker(
      barrierDismissible: false,
      context: event.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    TimeOfDay? time = await showTimePicker(
      barrierDismissible: false,
      context: event.context,
      initialTime: TimeOfDay.now(),
    );
    if (date != null && time != null) {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }
    return emit(DateTimeSelected(dateTime: _selectedDateTime));
  }

  void _back(AppBackPressed event, Emitter<AppState> emit) {
    emit(AppBack());
    emit(FetchTasksSuccess(tasks: _tasks));
  }

  void _togglePriority(TogglePriority event, Emitter<AppState> emit) {
    _isPrioritized = !_isPrioritized;
    return emit(PriorityToggled(isPrioritized: _isPrioritized));
  }

  Future<void> _fetchTasks(FetchTasks event, Emitter<AppState> emit) async {
    emit(FetchTasksLoading());
    final Either<Failure, List<TaskEntity>> tasks = await FetchTasksUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call();
    tasks.fold(
      (failure) => emit(FetchTasksFailed(message: failure.message)),
      (success) {
        _tasks = success;
        emit(FetchTasksSuccess(tasks: _tasks));
      },
    );
  }

  Future<void> _addTask(AddTaskEvent event, Emitter<AppState> emit) async {
    if (event.title.isEmpty || event.dateTime == null) {
      return emit(
        CheckTitleAndDateTimeState(
          title: event.title,
          dateTime: event.dateTime,
        ),
      );
    }
    emit(AddTaskLoading());
    final Either<Failure, TaskEntity> task = await AddTaskUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call(
      event.title,
      event.body,
      event.prioritized,
      event.status,
      event.dateTime!,
    );
    task.fold(
      (failure) => emit(AddTaskFailed(message: failure.message)),
      (success) {
        _tasks.add(success);
        emit(AddTaskSuccess(task: success));
        emit(FetchTasksSuccess(tasks: _tasks));
      },
    );
  }

  Future<void> _changeTaskStatus(
    ChangeTaskStatusEvent event,
    Emitter<AppState> emit,
  ) async {
    final Either<Failure, void> response = await ChangeTaskStatusUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call(
      event.status,
      event.task,
    );
    response.fold(
      (failure) => emit(ChangeTaskStatusFailure(message: failure.message)),
      (success) {
        final currentState = state;
        if (currentState is FetchTasksSuccess) {
          final tasks = List<TaskEntity>.from(currentState.tasks);
          tasks[event.index].status = event.status;
          emit(FetchTasksSuccess(tasks: tasks));
        }
      },
    );
  }

  Future<void> _changeTaskPriority(
    ChangeTaskPriorityEvent event,
    Emitter<AppState> emit,
  ) async {
    final Either<Failure, void> response = await ChangeTaskPriorityUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call(
      event.prioritized,
      event.task,
    );
    response.fold(
      (failure) => emit(ChangeTaskPriorityFailure(message: failure.message)),
      (success) {
        final currentState = state;
        if (currentState is FetchTasksSuccess) {
          final tasks = List<TaskEntity>.from(currentState.tasks);
          tasks[event.index].prioritized = event.prioritized;
          emit(FetchTasksSuccess(tasks: tasks));
        }
      },
    );
  }

  Future<void> _updateTask(
    UpdateTaskEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(UpdateTaskLoading());
    final Either<Failure, void> response = await UpdateTaskUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call(event.task);
    response.fold(
      (failure) {
        print('hh1');
        emit(UpdateTaskFailure(message: failure.message));
        print(failure.message);
      },
      (success) {
        print('hh');
        emit(UpdateTaskSuccess(task: event.task));
      },
    );
    add(FetchTasks());
  }

  Future<void> _deleteTask(
    DeleteTaskEvent event,
    Emitter<AppState> emit,
  ) async {
    final Either<Failure, void> response = await DeleteTaskUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call(event.task);
    response.fold(
      (failure) => emit(DeleteTaskFailed(message: failure.message)),
      (success) {
        final currentState = state;
        if (currentState is FetchTasksSuccess) {
          final tasks = List<TaskEntity>.from(currentState.tasks)
            ..remove(event.task);

          if (tasks.isEmpty) {
            emit(FetchTasksSuccess(tasks: tasks));
          } else {
            emit(FetchTasksSuccess(tasks: tasks));
          }
        }
      },
    );
  }

  Future<void> _signOut(SignOutRequested event, Emitter<AppState> emit) async {
    emit(SignOutLoading());
    final response = await SignOutUseCase(
      AppRepositoryImpl(
        appRemoteDataSource: AppRemoteDataSource(),
      ),
    ).call();
    response.fold(
      (failure) => emit(SignOutFailure(message: failure.message)),
      (success) => emit(SignOutSuccess()),
    );
    signInCheck!.clear();
  }
}
