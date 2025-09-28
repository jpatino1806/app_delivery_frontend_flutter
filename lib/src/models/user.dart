
import 'dart:convert';

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

    

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.sesionToken,
  });

    factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      email: json["email"],
      name: json["name"],
      lastname: json["lastname"],
      phone: json["phone"],
      image: json["image"],
      password: json["password"],
      sesionToken: json["sesion_token"],
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
        
    };
}
