import 'dart:convert';

class Category {
  String id;
  String name;
  _User user;

  Category({
    required this.id,
    required this.name,
    required this.user,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        name: json["name"],
        user: _User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "user": user.toJson(),
      };

  @override
  String toString() {
    return 'Category($name)';
  }
}

class _User {
  String id;
  String name;

  _User({
    required this.id,
    required this.name,
  });

  factory _User.fromRawJson(String str) => _User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _User.fromJson(Map<String, dynamic> json) => _User(
        id: json["_id"] ?? json["uid"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
