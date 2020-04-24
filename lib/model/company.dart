import 'dart:convert';

class Company {
  int compId;
  String name;
  String uEmail;

  Company({
    this.compId,
    this.name,
    this.uEmail,
  });

  Company.fromJson(Map jsonMap)
      : compId = jsonMap['comp_id'],
        name = jsonMap['name'],
        uEmail = jsonMap['u_email'];

  static Map toJson(Company company) => {
        'comp_id': company.compId,
        'name': company.name,
        'u_email': company.uEmail,
      };
  
  String toString() => JsonEncoder().convert(toJson(this));
}
