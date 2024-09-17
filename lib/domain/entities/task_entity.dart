class TaskEntity {
  final String? task_id;
  final String? user_id;
  final String title;
  final String body;
  late bool prioritized;
  late String? status;
  late String date_time;

  TaskEntity({
    this.task_id,
    this.user_id,
    required this.title,
    required this.body,
    required this.prioritized,
    required this.status,
    required this.date_time,
  });


}
