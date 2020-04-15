class Column {
  int colId;
  String name;
  String uEmail;
  int pId;

  Column({
    this.colId,
    this.name,
    this.uEmail,
    this.pId,
  });

  Column.fromJson(Map jsonMap)
      : colId = jsonMap['Col_ID'],
        name = jsonMap['Name'],
        uEmail = jsonMap['U_Email'],
        pId = jsonMap['P_ID'];
}
