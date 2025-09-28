import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/users_provider.dart';
import 'package:delivery_flutter/src/utils/my_snackbar.dart';
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
   
  }

  void register() async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || name.isEmpty || lastname.isEmpty || phone.isEmpty ||password.isEmpty || confirmPassword.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }
    if (confirmPassword != password) {
      MySnackbar.show(context!, 'Las contraseñas no coinciden');
      return;
    }
    if (password.length < 6) {
      MySnackbar.show(context!, 'La contraseña debe tener al menos 6 caracteres');
      return;
    }

    User user = User(
      email: email, 
      name: name, 
      lastname: lastname, 
      phone: phone, 
      password: password, id: '', image: '', sesionToken: '', 
      
    );

    ResponseApi? responseApi = await usersProvider.create(user);

    MySnackbar.show(context!, responseApi!.message ?? 'Ocurrió un error');

    if (responseApi.success == true) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context!, 'login');
      });
    }

 
    print('RESPUESTA: ${responseApi.toJson()}');
  }

  

  void back() {
    Navigator.pop(context!);
  }

}