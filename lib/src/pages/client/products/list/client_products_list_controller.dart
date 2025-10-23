import 'package:delivery_flutter/src/models/category.dart';
import 'package:delivery_flutter/src/models/product.dart';
import 'package:delivery_flutter/src/models/user.dart';
import 'package:delivery_flutter/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:delivery_flutter/src/provider/categories_provider.dart';
import 'package:delivery_flutter/src/provider/products_provider.dart';
import 'package:delivery_flutter/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ClientProductsListController {

  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  Function? refresh;
  User? user;
  final CategoriesProvider _categoriesProvider = CategoriesProvider();
  final ProductsProvider _productsProvider = ProductsProvider();
  List<Category> categories = [];



  Future? init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));

    _categoriesProvider.init(context, user!);
    _productsProvider.init(context, user!);

    // SchedulerBinding.instance.addPostFrameCallback((_) async{
    //   getCategories();
    //   refresh();
      
    // });

    getCategories();
    refresh();
    //return null;

    // Future.delayed(Duration.zero, () {
    //   getCategories();
    //   refresh();
    // });
  }





  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  
  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh!();
  }


  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
      context: context!, 
      builder: (context) => ClientProductsDetailPage(product: product)
    );
  }

  void logout(BuildContext context){ 
    _sharedPref.logout(context, user!.id!);
  }

  void openDrawer(){
     key.currentState?.openDrawer();
  }


  goToUpdatePage(BuildContext context) {
    Navigator.pushNamed(context, 'client/update');
  }


   //goToOrderCreatePage(BuildContext context) async {
  goToOrderCreatePage() {
    // Navigator.pop(context);
    // await Future.delayed(const Duration(milliseconds: 200));
    Navigator.pushNamed(context!, 'client/order/create');
  }

  void goToRoles(BuildContext context){
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }


}