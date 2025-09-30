import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class DeliveryOrdersListController {

  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();


  Future? init(BuildContext context){
    this.context = context;
    return null;
   
  }

  logout(BuildContext context){ 
    _sharedPref.logout(context);
  }

  openDrawer(){
     key.currentState?.openDrawer();
  }


}