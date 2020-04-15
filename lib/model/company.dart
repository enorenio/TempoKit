class Company {
  int compId;
  String name;
  String uEmail;
  int pId;

  Company({
    this.compId,
    this.name,
    this.uEmail,
    this.pId,
  });

  Company.fromJson(Map jsonMap)
      : compId = jsonMap['Comp_ID'],
        name = jsonMap['Name'],
        uEmail = jsonMap['U_Email'],
        pId = jsonMap['P_ID'];
}
