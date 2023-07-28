import 'package:admin_dashboard/models/User.dart';
import 'dart:convert';

class UsersResponse {
  String message;
  int total;
  List<User> users;

  UsersResponse({
    required this.message,
    required this.total,
    required this.users,
  });

  factory UsersResponse.fromRawJson(String str) =>
      UsersResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
        message: json["message"],
        total: json["total"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "total": total,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
