import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'package:admin_dashboard/api/backend_api.dart';
import 'package:admin_dashboard/models/User.dart';

class UserFormProvider extends ChangeNotifier {
  User? user;
  late GlobalKey<FormState> formKey;

  // implement how to update provider user
  void updateListener() {
    notifyListeners();
  }

  copyUserWith(
      {String? name,
      String? email,
      String? image,
      String? role,
      bool? isActive,
      bool? google,
      String? uid,
      String? id}) {
    user = User(
        name: name ?? user!.name,
        email: email ?? user!.email,
        image: image ?? user!.image,
        role: role ?? user!.role,
        isActive: isActive ?? user!.isActive,
        google: google ?? user!.google,
        uid: uid ?? user!.uid,
        id: id ?? user!.id);
    notifyListeners();
  }

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future<bool> updateUser() async {
    if (!_validForm()) return false;

    final data = {
      'name': user!.name,
      'email': user!.email,
    };

    try {
      await BackendApi.put('/users/${user!.uid}', data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> uploadImage(String path, Uint8List bytes) async {
    try {
      final response = await BackendApi.uploadFile(path, bytes);
      user = User.fromJson(response);
      notifyListeners();

      return user!;
    } catch (e) {
      throw 'Upload Image Error $e';
    }
  }
}
