import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/users_provider.dart';
import 'package:flutter/material.dart';

class RegisterController {

  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();


  Future? init(BuildContext context){

    this.context = context;
    usersProvider.init(context);
    return null;
  }

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    User user = User(
      email: email, 
      name: name, 
      lastname: lastname, 
      phone: phone, 
      password: password, 
      //id: '', 
      image: '', 
      sesionToken: '', 
      isAvailable: false
    );

    ResponseApi? responseApi = await usersProvider.create(user);
    print('RESPUESTA: ${responseApi?.toJson()}');
    
    print(email);
    print(name);
    print(lastname);
    print(phone);
    print(password);
    print(confirmPassword);
    


  }

}