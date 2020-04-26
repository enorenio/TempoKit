import 'dart:convert';

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
      : url = jsonMap['url'],
        uEmail = jsonMap['u_email'],
        taskId = jsonMap['task_id'];

  static Map toJson(File file) => {
        'url': file.url,
        'u_email': file.uEmail,
        'task_id': file.taskId,
      };

  static File fromString(String string) => File.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
