import 'dart:convert';

class Project {
  int pId;
  String name;
  String description;
  String uEmail;
  int compId;

  Project({
    this.pId,
    this.name,
    this.description,
    this.uEmail,
    this.compId,
  });

  Project.fromJson(Map jsonMap)
      : pId = jsonMap['p_id'],
        name = jsonMap['name'],
        description = jsonMap['description'],
        uEmail = jsonMap['u_email']??null,
        compId = jsonMap['comp_id']??null;

  static Map toJson(Project project) => {
        'p_id': project.pId,
        'name': project.name,
        'description': project.description,
        'u_email': project.uEmail,
        'comp_id': project.compId,
      };

  String toString() => JsonEncoder().convert(toJson(this));
}
