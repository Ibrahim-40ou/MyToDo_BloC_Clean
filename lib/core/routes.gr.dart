// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'routes.dart';

/// generated route for
/// [AddATask]
class AddATask extends PageRouteInfo<void> {
  const AddATask({List<PageRouteInfo>? children})
      : super(
          AddATask.name,
          initialChildren: children,
        );

  static const String name = 'AddATask';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const add.AddATask();
    },
  );
}

/// generated route for
/// [App]
class App extends PageRouteInfo<AppArgs> {
  App({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          App.name,
          args: AppArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'App';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppArgs>(orElse: () => const AppArgs());
      return app.App(key: args.key);
    },
  );
}

class AppArgs {
  const AppArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'AppArgs{key: $key}';
  }
}

/// generated route for
/// [ForgotPassword]
class ForgotPassword extends PageRouteInfo<ForgotPasswordArgs> {
  ForgotPassword({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotPassword.name,
          args: ForgotPasswordArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ForgotPassword';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordArgs>(
          orElse: () => const ForgotPasswordArgs());
      return forgot.ForgotPassword(key: args.key);
    },
  );
}

class ForgotPasswordArgs {
  const ForgotPasswordArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordArgs{key: $key}';
  }
}

/// generated route for
/// [InitialScreen]
class InitialRoute extends PageRouteInfo<void> {
  const InitialRoute({List<PageRouteInfo>? children})
      : super(
          InitialRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitialRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const initial.InitialScreen();
    },
  );
}

/// generated route for
/// [MyApp]
class MyApp extends PageRouteInfo<MyAppArgs> {
  MyApp({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          MyApp.name,
          args: MyAppArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MyAppArgs>(orElse: () => const MyAppArgs());
      return myapp.MyApp(key: args.key);
    },
  );
}

class MyAppArgs {
  const MyAppArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'MyAppArgs{key: $key}';
  }
}

/// generated route for
/// [Register]
class Register extends PageRouteInfo<RegisterArgs> {
  Register({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          Register.name,
          args: RegisterArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'Register';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<RegisterArgs>(orElse: () => const RegisterArgs());
      return register.Register(key: args.key);
    },
  );
}

class RegisterArgs {
  const RegisterArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'RegisterArgs{key: $key}';
  }
}

/// generated route for
/// [SignIn]
class SignIn extends PageRouteInfo<SignInArgs> {
  SignIn({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignIn.name,
          args: SignInArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignIn';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignInArgs>(orElse: () => const SignInArgs());
      return signin.SignIn(key: args.key);
    },
  );
}

class SignInArgs {
  const SignInArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignInArgs{key: $key}';
  }
}

/// generated route for
/// [ViewTask]
class ViewTask extends PageRouteInfo<ViewTaskArgs> {
  ViewTask({
    Key? key,
    required TaskEntity task,
    required bool editingMode,
    List<PageRouteInfo>? children,
  }) : super(
          ViewTask.name,
          args: ViewTaskArgs(
            key: key,
            task: task,
            editingMode: editingMode,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewTask';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewTaskArgs>();
      return view.ViewTask(
        key: args.key,
        task: args.task,
        editingMode: args.editingMode,
      );
    },
  );
}

class ViewTaskArgs {
  const ViewTaskArgs({
    this.key,
    required this.task,
    required this.editingMode,
  });

  final Key? key;

  final TaskEntity task;

  final bool editingMode;

  @override
  String toString() {
    return 'ViewTaskArgs{key: $key, task: $task, editingMode: $editingMode}';
  }
}

/// generated route for
/// [ViewTasks]
class ViewTasks extends PageRouteInfo<ViewTasksArgs> {
  ViewTasks({
    Key? key,
    required String page,
    List<PageRouteInfo>? children,
  }) : super(
          ViewTasks.name,
          args: ViewTasksArgs(
            key: key,
            page: page,
          ),
          initialChildren: children,
        );

  static const String name = 'ViewTasks';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ViewTasksArgs>();
      return views.ViewTasks(
        key: args.key,
        page: args.page,
      );
    },
  );
}

class ViewTasksArgs {
  const ViewTasksArgs({
    this.key,
    required this.page,
  });

  final Key? key;

  final String page;

  @override
  String toString() {
    return 'ViewTasksArgs{key: $key, page: $page}';
  }
}
