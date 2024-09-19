import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytodo_bloc/domain/entities/task_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

import '../../domain/failure/failure.dart';
import '../models/task_model.dart';

class AppRemoteDataSource {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final String? _userId = Supabase.instance.client.auth.currentUser?.id;
  final String _baseUrl =
      'https://oonuqdnkoghbrcxfytyj.supabase.co/rest/v1/tasks';
  final String _apiKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9vbnVxZG5rb2doYnJjeGZ5dHlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2Mjc4MTEsImV4cCI6MjAzOTIwMzgxMX0.g-DoCRQcuIcVYKbZTI-bX1so8xMcWZWD5CfHF6J1gkM';

  Future<Either<Failure, List<TaskModel>>> fetchTasks() async {
    List<TaskModel> tasks = [];
    if (_userId == null) {
      return Left(Failure(message: 'User not authenticated'));
    }
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?user_id=eq.$_userId'),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        for (var task in responseBody) {
          tasks.add(TaskModel.fromJson(task));
        }
        return Right(tasks);
      } else {
        return Left(Failure(message: 'failed to load tasks'.tr()));
      }
    } catch (e) {
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
    if (_userId == null) {
      return Left(Failure(message: 'user not authenticated'.tr()));
    }
    try {
      final TaskModel task = TaskModel(
        user_id: _userId,
        title: title,
        body: body,
        prioritized: prioritized,
        status: status,
        date_time: dateTime.toIso8601String(),
      );
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(task.toJson()),
      );
      if (response.statusCode == 201) {
        return Right(task);
      } else {
        return Left(Failure(message: 'failed to add task'.tr()));
      }
    } catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> changeTaskStatus(
    String status,
    TaskEntity task,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl?task_id=eq.${task.task_id}'),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': status}),
      );
      if (response.statusCode == 204) {
        return const Right(unit);
      } else {
        return Left(
          Failure(
            message: 'Failed to update task status: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> changeTaskPriority(
    bool prioritized,
    TaskEntity task,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl?task_id=eq.${task.task_id}'),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'prioritized': prioritized}),
      );
      if (response.statusCode == 204) {
        return const Right(unit);
      } else {
        return Left(
          Failure(
            message: 'Failed to update task priority: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    try {
      final response = await http.patch(
        Uri.parse('$_baseUrl?task_id=eq.${task.task_id!}'),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': task.user_id,
          'title': task.title,
          'body': task.body,
          'prioritized': task.prioritized,
          'status': task.status,
          'date_time': task.date_time,
        }),
      );
      if (response.statusCode == 204) {
        return const Right(unit);
      } else {
        return Left(
          Failure(
            message: 'Failed to update task: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
      return Left(Failure(message: '$e'));
    }
  }

  Future<Either<Failure, void>> deleteTask(TaskEntity task) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl?task_id=eq.${task.task_id}'),
        headers: {
          'apikey': _apiKey,
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 204) {
        return const Right(unit);
      } else {
        return Left(
          Failure(
            message: 'Failed to delete task: ${response.statusCode}',
          ),
        );
      }
    } on Exception catch (e) {
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
