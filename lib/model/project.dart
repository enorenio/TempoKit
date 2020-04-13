class Project {
  int pId;
  String name;
  String description;
  int uEmail;

  Project.fromJson(Map jsonMap)
      : pId = jsonMap['P_ID'],
        name = jsonMap['Name'],
        description = jsonMap['Description'],
        uEmail = jsonMap['U_Email'];
}
