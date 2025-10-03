import 'dart:convert';
import 'dart:io';

import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/users_provider.dart';
import 'package:delivery_flutter/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RegisterController {

  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;

  bool isEnable = true;


  Future? init(BuildContext context, Function refresh){

    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);

    return null;
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

    if (imageFile == null) {
      MySnackbar.show(context!, 'Selecciona una imagen');
      return;
    }

    _progressDialog?.show(max: 100, msg: 'espere un momento...');
    isEnable = false;

    User user = User(
      email: email, 
      name: name, 
      lastname: lastname, 
      phone: phone, 
      password: password //, id: '', image: '', sesionToken: '', 
    );

    Stream? stream = await usersProvider.createWithImage(user, imageFile!);
    stream?.listen((res) {

      _progressDialog?.close();

    //ResponseApi? responseApi = await usersProvider.create(user);
    ResponseApi? responseApi = ResponseApi.fromJson(json.decode(res));
    print('RESPUESTA: ${responseApi.toJson()}');

    MySnackbar.show(context!, responseApi.message ?? 'Ocurrió un error');

      if (responseApi.success == true) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context!, 'login');
        });
      }else{
        isEnable = true;
      }
    });

    
  }

 
  Future selectImage(ImageSource imageSource) async {
  final pickedFile = await ImagePicker().pickImage(source: imageSource); // ✅ Actual
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context!);
    refresh!();
  }



  void showAlertDialog(){
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery);
      }, 
      child: Text('GALERIA')
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera);
      }, 
      child: Text('CAMARA')
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(
      context: context!, 
      builder: (BuildContext context){
        return alertDialog;
      }
    );
  }


  void back() {
    Navigator.pop(context!);
  }

}