
import 'dart:async';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/provider/categories_provider.dart';
import 'package:delivery_flutter/src/utils/my_snackbar.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:delivery_flutter/src/models/category.dart';

class RestaurantProductsCreateController {

  BuildContext? context;
  Function? refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();

  CategoriesProvider _categoriesProvider = CategoriesProvider();
  User? user;
  SharedPref sharedPref = SharedPref();
  
  List<Category> categories = [];
  String? idCategory;

  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await sharedPref.read('user'));
    _categoriesProvider.init(context, user!);

    getCategories();

  }

  void getCategories() async{
    categories = (await _categoriesProvider.getAll()).cast<Category>();
    refresh!();
  }


  void createProduct() async{
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context!, 'Debes ingresar todos los campos');
      return;
    }
  }
}
