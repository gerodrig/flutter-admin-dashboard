import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('Form is valid');
      print('$name - $email - $password');
      return true;
    } else {
      print('Form is not valid');
      return false;
    }
  }
}
