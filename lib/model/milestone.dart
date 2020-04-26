import 'dart:convert';

class Milestone {
  int mId;
  String name;
  String description;
  String dueDate;
  String uEmail;
  int pId;

  Milestone({
    this.mId,
    this.name,
    this.description,
    this.dueDate,
    this.uEmail,
    this.pId,
  });

  Milestone.fromJson(Map jsonMap)
      : mId = jsonMap['m_id'],
        name = jsonMap['name'],
        description = jsonMap['description'],
        dueDate = jsonMap['due_date'],
        uEmail = jsonMap['u_email'],
        pId = jsonMap['p_id'];

  static Map toJson(Milestone milestone) => {
        'm_id': milestone.mId,
        'name': milestone.name,
        'description': milestone.description,
        'due_date': milestone.dueDate,
        'u_email': milestone.uEmail,
        'p_id': milestone.pId,
      };

  static Milestone fromString(String string) =>
      Milestone.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
