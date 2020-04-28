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
  
  static Company fromString(String string) => Company.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Company &&
      o.compId == compId &&
      o.name == name &&
      o.uEmail == uEmail;
  }

  @override
  int get hashCode => compId.hashCode ^ name.hashCode ^ uEmail.hashCode;
}
