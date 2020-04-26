import 'dart:convert';

class Task {
  int taskId;
  String name;
  String description;
  String dueDate;
  int mId;
  int colId;
  String uEmail;

  Task({
    this.taskId,
    this.name,
    this.description,
    this.dueDate,
    this.mId,
    this.colId,
    this.uEmail,
  });

  Task.fromJson(Map jsonMap)
      : taskId = jsonMap['task_id'],
        name = jsonMap['name'],
        description = jsonMap['description'],
        dueDate = jsonMap['due_date'],
        mId = jsonMap['m_id'],
        colId = jsonMap['col_id'],
        uEmail = jsonMap['u_email'];

  static Map toJson(Task task) => {
        'task_id': task.taskId,
        'name': task.name,
        'description': task.description,
        'due_date': task.dueDate,
        'm_id': task.mId,
        'col_id': task.colId,
        'u_email': task.uEmail,
      };

  static Task fromString(String string) => Task.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
