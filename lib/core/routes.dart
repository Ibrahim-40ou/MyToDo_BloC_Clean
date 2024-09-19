import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mytodo_bloc/presentation/pages/auth/sign_in.dart' as signin;
import 'package:mytodo_bloc/presentation/pages/app/app.dart' as app;
import 'package:mytodo_bloc/main.dart' as myapp;
import 'package:mytodo_bloc/core/initial_route.dart' as initial;
import 'package:mytodo_bloc/presentation/pages/auth/register.dart' as register;
import 'package:mytodo_bloc/presentation/pages/auth/forgot_password.dart'
    as forgot;
import 'package:mytodo_bloc/presentation/pages/app/add_task.dart' as add;
import 'package:mytodo_bloc/presentation/pages/app/view_task.dart' as view;
import 'package:mytodo_bloc/presentation/pages/app/view_tasks.dart' as views;

import '../domain/entities/task_entity.dart';

part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitialRoute.page, initial: true),
        AutoRoute(page: App.page),
        AutoRoute(page: MyApp.page),
        AutoRoute(page: SignIn.page),
        AutoRoute(page: ForgotPassword.page),
        AutoRoute(page: Register.page),
        AutoRoute(page: AddATask.page),
        AutoRoute(page: ViewTask.page),
        AutoRoute(page: ViewTasks.page),
      ];
}
