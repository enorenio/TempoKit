import 'dart:convert';

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
      : colId = jsonMap['col_id'],
        name = jsonMap['name']??jsonMap['col_name'],
        uEmail = jsonMap['u_email'],
        pId = jsonMap['p_id'];

  static Map toJson(Column column) => {
        'col_id': column.colId,
        'name': column.name,
        'u_email': column.uEmail,
        'p_id': column.pId,
      };

  static Column fromString(String string) =>
      Column.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
