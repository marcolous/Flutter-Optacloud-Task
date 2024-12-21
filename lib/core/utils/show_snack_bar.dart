import 'package:flutter/material.dart';

class ShowSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
