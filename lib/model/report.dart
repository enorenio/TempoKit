class Report {
  int rId;
  String name;
  String submitDate;

  Report.fromJson(Map jsonMap)
      : rId = jsonMap['R_ID'],
        name = jsonMap['Name'],
        submitDate = jsonMap['Submit_Date'];
}
