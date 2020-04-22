import 'dart:convert';

class User {
  String uEmail;
  String fullName;
  String password;
  String workType;

  final JsonEncoder jsonEncoder = JsonEncoder();

  User({
    this.uEmail,
    this.fullName,
    this.password,
    this.workType,
  });

  //TODO: make it factory instead of this thing
  User.fromJson(Map jsonMap)
      : uEmail = jsonMap['u_email'],
        fullName = jsonMap['full_name'],
        password = jsonMap['password'] ?? '',
        workType = jsonMap['work_type'] ?? '';

  Map toJson() {
    return {
      'u_email': uEmail,
      'full_name': fullName,
      'password': password,
      'work_type': workType,
    };
  }

  // wrong, do that correctly some day
  // User.fromString(String string) {
  //   Map _jsonMap = json.decode(string);
  //   User.fromJson(_jsonMap);
  // }

  String toString() {
    return jsonEncoder.convert(this.toJson());
  }
}
