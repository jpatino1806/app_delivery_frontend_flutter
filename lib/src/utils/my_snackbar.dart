import 'package:flutter/material.dart';

class MySnackbar {
  static void show(BuildContext context, String text){
    // ignore: unnecessary_null_comparison
    if (context == null) return;

    FocusScope.of(context).requestFocus(FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14
        ),
      ),
        backgroundColor: Colors.black,
        duration: Duration(seconds: 3),
      )
    );
  }
}