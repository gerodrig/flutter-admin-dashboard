import 'package:flutter/material.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/api/backend_api.dart';

import 'package:admin_dashboard/models/http/auth_response.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  User? user;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    final data = {
      'email': email,
      'password': password,
    };

    BackendApi.post('/auth/login', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      user = authResponse.user;

      // _token = 'sdaffsdafsdal;fdasjkfjlkdsflk;js';
      LocalStorage.preferences!.setString('token', authResponse.token);

      // Navigate to dashboard
      authStatus = AuthStatus.authenticated;

      BackendApi.configureDio();

      notifyListeners();
      NavigationService.replaceTo('/dashboard');
    }).catchError((err) {
      NotificationService.showSnackbarError(err.toString());
    });
  }

  register(String email, String password, String name) {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    BackendApi.post('/users', data).then((json) {
      final authResponse = AuthResponse.fromJson(json);
      user = authResponse.user;

      // Navigate to dashboard
      authStatus = AuthStatus.authenticated;
      LocalStorage.preferences!.setString('token', authResponse.token);

      BackendApi.configureDio();

      notifyListeners();
      NavigationService.replaceTo('/dashboard');
    }).catchError((err) {
      NotificationService.showSnackbarError(err.toString());
    });

    // _token = 'sdaffsdafsdal;fdasjkfjlkdsflk;js';
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.preferences!.getString('token');

    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    try {
      final response = await BackendApi.httpGet('/auth');
      final authResponse = AuthResponse.fromJson(response);

      //Save new token
      LocalStorage.preferences!.setString('token', authResponse.token);
      user = authResponse.user;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      // print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.preferences!.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
