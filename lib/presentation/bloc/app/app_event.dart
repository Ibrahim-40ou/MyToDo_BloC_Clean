part of 'app_bloc.dart';

@immutable
sealed class AppEvent {}

class FetchTasks extends AppEvent {}

class AppBackPressed extends AppEvent {}

class AddTaskEvent extends AppEvent {
  final String title;
  final String body;
  final bool prioritized;
  final String status;
  final DateTime? dateTime;

  AddTaskEvent({
    required this.title,
    required this.body,
    required this.prioritized,
    required this.status,
    required this.dateTime,
  });
}

class TogglePriority extends AppEvent {}

class PickDateTime extends AppEvent {
  final BuildContext context;

  PickDateTime({required this.context});
}

class ChangeTaskStatusEvent extends AppEvent {
  final TaskEntity task;
  final String status;
  final int index;

  ChangeTaskStatusEvent({
    required this.status,
    required this.task,
    required this.index,
  });
}

class ChangeTaskPriorityEvent extends AppEvent {
  final TaskEntity task;
  final bool prioritized;
  final int index;

  ChangeTaskPriorityEvent({
    required this.prioritized,
    required this.task,
    required this.index,
  });
}

class UpdateTaskEvent extends AppEvent {
  final TaskEntity task;

  UpdateTaskEvent({required this.task});
}

class DeleteTaskEvent extends AppEvent {
  final TaskEntity task;

  DeleteTaskEvent({required this.task});
}

class SignOutRequested extends AppEvent {}

class ChangeTheme extends AppEvent {
  final bool isDarkMode;

  ChangeTheme({required this.isDarkMode});
}

class LoadTheme extends AppEvent {
  final bool isDarkMode;

  LoadTheme({required this.isDarkMode});
}

class FetchedTasksEvent extends AppEvent {}

class ChangeLanguage extends AppEvent {
  final bool isArabic;
  final BuildContext context;

  ChangeLanguage({
    required this.isArabic,
    required this.context,
  });
}
