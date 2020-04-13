class Tag {
  int tagId;
  String name;
  String color;
  String uEmail;

  Tag.fromJson(Map jsonMap)
      : tagId = jsonMap['Tag_ID'],
        name = jsonMap['Name'],
        color = jsonMap['Color'],
        uEmail = jsonMap['U_Email'];
}
