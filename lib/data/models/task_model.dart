import 'package:mytodo_bloc/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.task_id,
    required super.user_id,
    required super.title,
    required super.body,
    required super.prioritized,
    required super.status,
    required super.date_time,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      task_id: json['task_id'],
      user_id: json['user_id'],
      title: json['title'],
      body: json['body'],
      prioritized: json['prioritized'],
      status: json['status'],
      date_time: json['date_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'title': title,
      'body': body,
      'prioritized': prioritized,
      'status': status,
      'date_time': date_time,
    };
  }

  factory TaskModel.fromEntity(TaskEntity entity) {
    return TaskModel(
      task_id: entity.task_id,
      user_id: entity.user_id,
      title: entity.title,
      body: entity.body,
      prioritized: entity.prioritized,
      status: entity.status,
      date_time: entity.date_time,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      task_id: task_id,
      user_id: user_id,
      title: title,
      body: body,
      prioritized: prioritized,
      status: status,
      date_time: date_time,
    );
  }
}
