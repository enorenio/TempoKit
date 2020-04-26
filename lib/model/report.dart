import 'dart:convert';

class Report {
  int rId;
  String name;
  String submitDate;

  Report({
    this.rId,
    this.name,
    this.submitDate,
  });

  Report.fromJson(Map jsonMap)
      : rId = jsonMap['r_id'],
        name = jsonMap['name'],
        submitDate = jsonMap['submit_date'];

  static Map toJson(Report report) => {
        'r_id': report.rId,
        'name': report.name,
        'submit_date': report.submitDate,
      };

  static Report fromString(String string) =>
      Report.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
