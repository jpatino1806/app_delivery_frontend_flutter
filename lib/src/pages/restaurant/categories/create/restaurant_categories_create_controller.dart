
import 'dart:async';

import 'package:delivery_flutter/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';

class RestaurantCategoriesCreateController {

  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future? init(BuildContext context, Function refresh){
    this.context = context;
    this.refresh = refresh;
  }

  void createCategory(){
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }

    print('NOMBRE: $name');
    print('DESCRIPCION: $description');

  }

  


}
