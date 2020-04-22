import 'dart:convert';

class Project {
  int pId;
  String name;
  String description;
  String uEmail;

  final JsonEncoder jsonEncoder = JsonEncoder();

  Project({
    this.pId,
    this.name,
    this.description,
    this.uEmail,
  });

  Project.fromJson(Map jsonMap)
      : pId = jsonMap['P_ID'],
        name = jsonMap['Name'],
        description = jsonMap['Description'],
        uEmail = jsonMap['U_Email'];

  Map toJson() {
    return {
      'p_id': pId,
      'name': name,
      'description': description,
      'u_email': uEmail,
    };
  }

  String toString() {
    return jsonEncoder.convert(this.toJson());
  }
}
