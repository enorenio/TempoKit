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
      : uEmail = jsonMap['email'],
        fullName = jsonMap['full_name'],
        password = jsonMap['password'],
        workType = jsonMap['work_type'];

  Map toJson() {
    return {
      'email': uEmail,
      'full_name': fullName,
      'password': password,
      'work_type': workType,
    };
  }
}
