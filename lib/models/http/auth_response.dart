import 'dart:convert';

import 'package:admin_dashboard/models/User.dart';

class AuthResponse {
  String? message;
  User user;
  String token;

  AuthResponse({
    this.message = 'Ok',
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromRawJson(String str) =>
      AuthResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "token": token,
      };
}
