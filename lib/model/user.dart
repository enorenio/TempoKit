import 'dart:convert';

class User {
  String uEmail;
  String fullName;
  String password;
  String workType;

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

  static Map toJson(User user) => {
        'u_email': user.uEmail,
        'full_name': user.fullName,
        'password': user.password,
        'work_type': user.workType,
      };

  static User fromString(String string) => User.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
