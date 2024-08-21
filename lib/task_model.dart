class TaskModel {
  final String title;
  final String subtitle;
  bool? isDone;

  TaskModel({
    required this.title,
    required this.subtitle,
    this.isDone = false
  });
}