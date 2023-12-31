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

  static showSnackbarSuccess(String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green.withOpacity(0.9),
      content: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 20)),
    );

    scaffoldKey.currentState!.showSnackBar(snackBar);
  }

  static showBusyIndicator(BuildContext context) {
    const AlertDialog dialog = AlertDialog(
      content: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: CircularProgressIndicator(),
          )),
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}
