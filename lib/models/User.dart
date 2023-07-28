import 'dart:convert';

class User {
  String name;
  String email;
  String? image;
  String role;
  bool isActive;
  bool? google;
  String? uid;
  String? id;

  User({
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
    this.google,
    this.uid,
    this.id,
    this.image,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        image: json["image"],
        role: json["role"],
        isActive: json["isActive"],
        google: json["google"],
        uid: json["uid"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "image": image,
        "role": role,
        "isActive": isActive,
        "google": google,
        "uid": uid,
        "_id": id,
      };

  @override
  String toString() {
    return 'User(name: $name, email: $email, image: $image, role: $role, isActive: $isActive, google: $google, uid: $uid, id: $id)';
  }
}
