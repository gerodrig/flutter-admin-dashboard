import 'package:flutter/material.dart';

import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:admin_dashboard/models/Category.dart';

import 'package:admin_dashboard/api/backend_api.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Category> categories = [];

  getCategories() async {
    final response = await BackendApi.httpGet('/categories');
    final categoriesResponse = CategoriesResponse.fromJson(response);

    categories = [...categoriesResponse.categories];

    // print(categories);

    notifyListeners();
  }

  Future newCategory(String name) async {
    final data = {'name': name};

    try {
      final json = await BackendApi.post('/categories', data);
      final newCategory = CategoriesResponse.fromJson(json);

      categories.add(newCategory.category!);
      notifyListeners();
    } catch (e) {
      throw 'Error in $e';
    }
  }

  Future updateCategory(String id, String name) async {
    final data = {'name': name};

    try {
      final json = await BackendApi.put('/categories/$id', data);
      final newCategory = CategoriesResponse.fromJson(json);

      int index = categories.indexWhere((category) => category.id == id);
      if (index != -1) {
        categories[index] = newCategory.category!;
      }
      notifyListeners();
    } catch (e) {
      throw 'Error in $e';
    }
  }

  Future deleteCategory(String id) async {
    try {
      await BackendApi.delete('/categories/$id', {});

      categories.removeWhere((category) => category.id == id);
      notifyListeners();
    } catch (e) {
      throw 'Error in $e';
    }
  }
}
