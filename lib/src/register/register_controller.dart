import 'package:flutter/material.dart';

class RegisterController {

  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  Future? init(BuildContext context){

    this.context = context;
    return null;
  }

  void register() {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    
    print(email);
    print(name);
    print(lastName);
    print(phone);
    print(password);
    print(confirmPassword);
    


  }

}