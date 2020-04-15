class Comment {
  int commId;
  String text;
  String uEmail;
  int taskId;

  Comment({
    this.commId,
    this.text,
    this.uEmail,
    this.taskId,
  });

  Comment.fromJson(Map jsonMap)
      : commId = jsonMap['Comm_ID'],
        text = jsonMap['Text'],
        uEmail = jsonMap['U_Email'],
        taskId = jsonMap['Task_ID'];
}
