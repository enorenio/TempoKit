import 'dart:convert';

class Tag {
  int tagId;
  String name;
  String color;

  Tag({
    this.tagId,
    this.name,
    this.color,
  });

  Tag.fromJson(Map jsonMap)
      : tagId = jsonMap['tag_id'],
        name = jsonMap['name'],
        color = jsonMap['color'];

  static Map toJson(Tag tag) => {
        'tag_id': tag.tagId,
        'name': tag.name,
        'color': tag.color,
      };

  static Tag fromString(String string) => Tag.fromJson(json.decode(string));

  String toString() => JsonEncoder().convert(toJson(this));
}
