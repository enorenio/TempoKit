import 'dart:convert';

class Tag {
  int tagId;
  String name;
  String color;
  String uEmail;

  Tag({
    this.tagId,
    this.name,
    this.color,
    this.uEmail,
  });

  Tag.fromJson(Map jsonMap)
      : tagId = jsonMap['tag_id'],
        name = jsonMap['name'],
        color = jsonMap['color'],
        uEmail = jsonMap['u_email'];

  static Map toJson(Tag tag) => {
        'tag_id': tag.tagId,
        'name': tag.name,
        'color': tag.color,
        'u_email': tag.uEmail,
      };

  static Tag fromString(String string) => Tag.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
