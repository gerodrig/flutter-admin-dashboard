import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) {
    //TODO: HTTP request

    _token = 'sdaffsdafsdal;fdasjkfjlkdsflk;js';
    LocalStorage.preferences!.setString('token', _token!);

    // Navigate to dashboard
    authStatus = AuthStatus.authenticated;
    notifyListeners();

    NavigationService.replaceTo('/dashboard');
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.preferences!.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //TODO: backend HTTP request to check if JWt is valid.

    await Future.delayed(Duration(milliseconds: 1000));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}
