class File {
  String url;
  String uEmail;
  int taskId;

  File({
    this.url,
    this.uEmail,
    this.taskId,
  });

  File.fromJson(Map jsonMap)
      : url = jsonMap['URL'],
        uEmail = jsonMap['U_Email'],
        taskId = jsonMap['Task_ID'];
}
