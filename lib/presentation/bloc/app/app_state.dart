part of 'app_bloc.dart';

sealed class AppState {}

class AppInitial extends AppState {}

class AppBack extends AppState {}

class FetchTasksLoading extends AppState {}

class FetchTasksSuccess extends AppState {
  List<TaskEntity> tasks;

  FetchTasksSuccess({required this.tasks});
}

class FetchTasksFailed extends AppState {
  final String message;

  FetchTasksFailed({required this.message});
}

class AddTaskLoading extends AppState {}

class AddTaskSuccess extends AppState {
  final TaskEntity task;

  AddTaskSuccess({required this.task});
}

class AddTaskFailed extends AppState {
  final String message;

  AddTaskFailed({required this.message});
}

class PriorityToggled extends AppState {
  final bool isPrioritized;

  PriorityToggled({required this.isPrioritized});
}

class DateTimeSelected extends AppState {
  final DateTime? dateTime;

  DateTimeSelected({this.dateTime});
}

class CheckTitleAndDateTimeState extends AppState {
  final String title;
  final DateTime? dateTime;

  CheckTitleAndDateTimeState({
    required this.title,
    required this.dateTime,
  });
}

class ChangeTaskStatusState extends AppState {}

class ChangeTaskStatusSuccess extends AppState {}

class ChangeTaskStatusFailure extends AppState {
  final String message;

  ChangeTaskStatusFailure({required this.message});
}

class ChangeTaskPriorityState extends AppState {}

class ChangeTaskPrioritySuccess extends AppState {}

class ChangeTaskPriorityFailure extends AppState {
  final String message;

  ChangeTaskPriorityFailure({required this.message});
}

class UpdateTaskLoading extends AppState {}

class UpdateTaskFailure extends AppState {
  final String message;

  UpdateTaskFailure({required this.message});
}

class UpdateTaskSuccess extends AppState {
  final TaskEntity task;

  UpdateTaskSuccess({required this.task});
}

class DeleteTaskState extends AppState {}

class DeleteTaskFailed extends AppState {
  final String message;

  DeleteTaskFailed({required this.message});
}

class DeleteTaskSuccess extends AppState {}

class SignOutLoading extends AppState {}

class SignOutSuccess extends AppState {}

class SignOutFailure extends AppState {
  final String message;

  SignOutFailure({required this.message});
}

class ThemeChanged extends AppState {
  final bool isDarkMode;

  ThemeChanged({required this.isDarkMode});
}

class LanguageChanged extends AppState {
  final bool isArabic;

  LanguageChanged({required this.isArabic});
}
