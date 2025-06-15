class AddTask {
  String content;
  DateTime dateTime;
  bool isDone;

  AddTask({
    required this.content,
    required this.dateTime,
    required this.isDone,
  });

  factory AddTask.fromMap(Map task) {
    return AddTask(
      content: task['content'],
      dateTime: task['dateTime'],
      isDone: task['isDone'],
    );
  }
  Map toMap() {
    return {
      'content': content,
      'dateTime': dateTime,
      'isDone': isDone,
    };
  }
}
