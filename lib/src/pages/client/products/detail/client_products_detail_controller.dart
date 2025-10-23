
import 'package:delivery_flutter/src/models/product.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController {
  
  BuildContext? context;
  Function? refresh;
  Product? product;

  int counter = 1;
  double? productPrice;

  final SharedPref _sharedPref = SharedPref();

  List<Product> selectedProducts = [];


  Future? init(BuildContext context, Function refresh, Product product) async{
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    productPrice = product.price;
    //_sharedPref.remove('order');
    var orderData = await _sharedPref.read('order');
 
    if (orderData != null) {
      selectedProducts = Product.fromJsonList(orderData).toList;
    } else {
      selectedProducts = [];
    }
    selectedProducts.forEach((p) {
      //print('Producto seleccionado: ${p.toJson()}');
    },);

    refresh();
    return null; 
  }


  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product!.id);

    if (index == -1) { //si es -1 no existen productos seleccionados
      if (product!.quantity == null) {
        product!.quantity = 1;
      }
      selectedProducts.add(product!);
    }else{
      selectedProducts[index].quantity = counter;
    }
    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Producto agregado a la bolsa');
  }

  void addItem(){
    counter = counter + 1;
    productPrice = product!.price! * counter;
    product!.quantity = counter;
    refresh!();
  }

  void removeItem(){
    if (counter > 1) {
      counter = counter - 1;
      productPrice = product!.price! * counter;
      product!.quantity = counter;
      refresh!();
    }
  }

  void close(){
    Navigator.pop(context!);
  }

}
