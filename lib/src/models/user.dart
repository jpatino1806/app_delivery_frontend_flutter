
import 'dart:convert';

import 'package:delivery_flutter/src/models/rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? sesionToken;
  List<Rol> roles = [];

    

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.sesionToken,
    List<Rol>? roles,
  }) : roles = roles ?? [];

    factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"] is int ? json['id'].toString() : json['id'],
      email: json["email"],
      name: json["name"],
      lastname: json["lastname"],
      phone: json["phone"],
      image: json["image"],
      password: json["password"],
      sesionToken: json["sesion_token"],
      roles: json["roles"] == null ? [] : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))) ?? [],
  );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "sesion_token": sesionToken,
        "roles": roles,
        
    };
}
