import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbarError(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
