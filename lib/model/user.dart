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

  User.fromJson(Map jsonMap)
      : uEmail = jsonMap['U_Email'],
        fullName = jsonMap['Full_Name'],
        password = jsonMap['Password'],
        workType = jsonMap['Work_Type'];
}
