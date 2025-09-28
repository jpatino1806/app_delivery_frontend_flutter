import 'dart:convert';

//import 'package:delivery_flutter/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPref{
  //String? get user => null;


  void save(String key, value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }


  Future<dynamic> read(String key) async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key)!);
  }


  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  
  void logout(BuildContext context) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    //Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
  }

  // Future<void> logout(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('user'); // Limpia todos los datos guardados
  //   Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false); // Limpia el stack y navega a login
  // }
  
  
}