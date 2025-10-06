import 'dart:convert';
import 'dart:io';

import 'package:delivery_flutter/src/models/response_api.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/users_provider.dart';
import 'package:delivery_flutter/src/utils/my_snackbar.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ClientUpdateController {

  BuildContext? context;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  

  UsersProvider usersProvider = UsersProvider();

  PickedFile? pickedFile;
  File? imageFile;
  Function? refresh;

  ProgressDialog? _progressDialog;

  bool isEnable = true;

  User? user;
  final SharedPref _sharedPref = SharedPref();



  //////////////////////////////////////////////////////////
  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context, token: user?.sesionToken);
    nameController.text = user!.name!;
    lastnameController.text = user!.lastname!;
    phoneController.text = user!.phone!;
    refresh();
    
    return null;
  }

  //////////////////////////////////////////////////////////////////
  void update() async{
    
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();
   

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }
    
    // if (imageFile == null) {
    //   MySnackbar.show(context!, 'Selecciona una imagen');
    //   return;
    // }

    _progressDialog?.show(max: 100, msg: 'espere un momento...');
    isEnable = false;

    User myUser = User(
      id: user!.id,
      name: name, 
      lastname: lastname, 
      phone: phone, 
      image: user?.image
      
    );

    //Stream? stream = await usersProvider.update(myUser, imageFile!);
    Stream? stream;

    if (imageFile != null) {
    stream = await usersProvider.update(myUser, imageFile!);
    } else {
    stream = await usersProvider.updateNoImage(myUser);
    }

    
    stream?.listen((res) async {

    _progressDialog?.close();

    //ResponseApi? responseApi = await usersProvider.create(user);
    ResponseApi? responseApi = ResponseApi.fromJson(json.decode(res));
      Fluttertoast.showToast(msg: responseApi.message ?? 'Ocurrio un error');
    
      if (responseApi.success == true) {

        user = await usersProvider.getById(myUser.id!); //obteniendo usuario de la base de datos
        print('usuario obtenido: ${user?.toJson()}');
        _sharedPref.save('user', user?.toJson());
        
        Navigator.pushNamedAndRemoveUntil(context!, 'client/products/list', (route) => false);
      }else{
        isEnable = true;
      }
    });
  }

  //////////////////////////////////////////////////////////////////////////
  Future selectImage(ImageSource imageSource) async {
  final pickedFile = await ImagePicker().pickImage(source: imageSource); // ✅ Actual
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context!);
    refresh!();
  }


  /////////////////////////////////////////////////////////////////////////
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


  /////////////////////////////////////////////////////////
  void back() {
    Navigator.pop(context!);
  }

}