import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/failure/failure.dart';
import '../models/task_model.dart';

class AppRemoteDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String? userId = Supabase.instance.client.auth.currentUser?.id;

  Future<Either<Failure, List<TaskModel>>> fetchTasks() async {
    List<TaskModel> tasks = [];
    if (userId == null) {
      return Left(Failure(message: 'User not authenticated'));
    }
    try {
      final List<Map<String, dynamic>> response = await _supabaseClient
          .from('tasks')
          .select('*')
          .eq('user_id', userId!);
      for (Map<String, dynamic> task in response) {
        tasks.add(TaskModel.fromJson(task));
      }
      return Right(tasks);
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, TaskModel>> addTask(
    String title,
    String body,
    bool prioritized,
    String status,
    DateTime dateTime,
  ) async {
    if (userId == null) {
      return Left(Failure(message: 'User not authenticated'));
    }
    try {
      final TaskModel task = TaskModel(
        user_id: userId!,
        title: title,
        body: body,
        prioritized: prioritized,
        status: status,
        date_time: dateTime.toIso8601String(),
      );
      await _supabaseClient.from('tasks').insert(task.toJson());
      return Right(task);
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> changeTaskStatus(
    String status,
    TaskEntity task,
  ) async {
    try {
      await _supabaseClient.from('tasks').update(
        {'status': status},
      ).eq(
        'task_id',
        task.task_id!,
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> changeTaskPriority(
    bool prioritized,
    TaskEntity task,
  ) async {
    try {
      await _supabaseClient.from('tasks').update(
        {'prioritized': prioritized},
      ).eq(
        'task_id',
        task.task_id!,
      );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    try {
      await _supabaseClient
          .from('tasks')
          .update(TaskModel(
            user_id: task.user_id,
            title: task.title,
            body: task.body,
            prioritized: task.prioritized,
            status: task.status,
            date_time: task.date_time,
          ).toJson())
          .eq(
            'task_id',
            task.task_id!,
          );
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> deleteTask(TaskEntity task) async {
    try {
      await _supabaseClient.from('tasks').delete().eq('task_id', task.task_id!);
      print(task.task_id);
      print('hey');
      return const Right(unit);
    } on Exception catch (e) {
      print('$e');
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
      await GoogleSignIn().signOut();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }
}
