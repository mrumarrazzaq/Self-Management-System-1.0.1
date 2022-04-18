class TodoField {
  static const createdTime = 'createdTime';
}

class HabitTodo {
  DateTime createdTime;
  String title;
  String id;
  String description;
  bool isDone;

  HabitTodo(
      {required this.createdTime,
      this.id = '',
      required this.title,
      this.description = '',
      this.isDone = false});
}
