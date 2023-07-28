import 'dart:convert';

import 'package:admin_dashboard/models/Category.dart';

class CategoriesResponse {
  int total;
  List<Category> categories;
  Category? category;
  String? message;

  CategoriesResponse(
      {this.total = 1,
      this.categories = const [],
      this.category,
      this.message});

  factory CategoriesResponse.fromRawJson(String str) =>
      CategoriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        total: json["total"] ?? 1,
        categories: json["categories"] != null
            ? List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x)))
            : [],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "category": category,
        "message": message,
      };
}
