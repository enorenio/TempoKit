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

  Map toJson() {
    return {
      'task_id': taskId,
      'name': name,
      'description': description,
      'due_date': dueDate,
      'm_id': mId,
      'col_id': colId,
      'u_email': uEmail,
    };
  }

  String toString() {
    return JsonEncoder().convert(this.toJson());
  }
}
