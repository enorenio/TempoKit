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
      : taskId = jsonMap['Task_ID'],
        name = jsonMap['Name'],
        description = jsonMap['Description'],
        dueDate = jsonMap['Due_Date'],
        mId = jsonMap['M_ID'],
        colId = jsonMap['Col_ID'],
        uEmail = jsonMap['U_Email'];
}
