import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/backend_api.dart';

import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:admin_dashboard/models/http/user_response.dart';
import 'package:admin_dashboard/models/User.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex = 1;

  UsersProvider() {
    getPaginatedUsers();
  }

  Future<void> getPaginatedUsers() async {
    final response = await BackendApi.httpGet('/users?limit=100&offset=0');
    final usersResponse = UsersResponse.fromJson(response);

    users = [...usersResponse.users];

    isLoading = false;

    notifyListeners();
  }

  Future<User?> getUserById(String uid) async {
    try {
      final response = await BackendApi.httpGet('/users/$uid');
      final user = UserResponse.fromJson(response).user;

      return user;
    } catch (e) {
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(User user) getField) {
    users.sort((a, b) {
      return ascending
          ? Comparable.compare(getField(a), getField(b))
          : Comparable.compare(getField(b), getField(a));
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refreshUser(User newUser) {
    users = users.map((user) {
      if (user.uid == newUser.uid) {
        user = newUser;
      }
      return user;
    }).toList();

    notifyListeners();
  }
}
