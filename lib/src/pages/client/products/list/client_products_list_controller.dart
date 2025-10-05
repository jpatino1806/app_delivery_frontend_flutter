import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientProductsListController {

  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Function? refresh;
  User? user;



  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
    return null;

  }

  void logout(BuildContext context){ 
    _sharedPref.logout(context);
  }

  void openDrawer(){
     key.currentState?.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context!, 'client/update');
  }


  void goToRoles(){
    Navigator.pushNamedAndRemoveUntil(context!, 'roles', (route) => false);
  }


}