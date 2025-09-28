
import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/users_provider.dart';
import 'package:delivery_flutter/src/utils/my_snackbar.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginController {

  BuildContext? context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  final SharedPref _sharedPref = SharedPref();
  

  Future? init(BuildContext context) async{
    this.context = context;
    await usersProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    print('Usuario : ${user.toJson()}');
    
    //Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    if (user.id != null) {
      Navigator.pushNamedAndRemoveUntil(context, 'client/products/list', (route) => false);
    }
  }

  void goToRegisterPage(){
    Navigator.pushNamed(context!, 'register');
  }

  void login() async{
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi?  responseApi = await usersProvider.login(email, password);

    if (responseApi != null && responseApi.success == true) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);

    } else {
      MySnackbar.show(context!, responseApi?.message ?? 'error desconocido');
    }

    
  }
}