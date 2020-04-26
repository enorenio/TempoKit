import 'dart:convert';

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
      : commId = jsonMap['comm_id'],
        text = jsonMap['text'],
        uEmail = jsonMap['u_email'],
        taskId = jsonMap['task_id'];

  static Map toJson(Comment comment) => {
        'comm_id': comment.commId,
        'text': comment.text,
        'u_email': comment.uEmail,
        'task_id': comment.taskId,
      };

  static Comment fromString(String string) =>
      Comment.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
