class Milestone {
  int mId;
  String name;
  String description;
  String dueDate;
  String uEmail;
  int pId;

  Milestone.fromJson(Map jsonMap)
      : mId = jsonMap['M_ID'],
        name = jsonMap['Name'],
        description = jsonMap['Description'],
        dueDate = jsonMap['Due_Date'],
        uEmail = jsonMap['U_Email'],
        pId = jsonMap['P_ID'];
}
