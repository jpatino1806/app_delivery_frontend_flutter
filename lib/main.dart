import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:delivery_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_flutter/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_flutter/src/pages/login/login_page.dart';
import 'package:delivery_flutter/src/pages/register/register_page.dart';
import 'package:delivery_flutter/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:delivery_flutter/src/pages/roles/roles_page.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery App Flutter',
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'register': (context) => RegisterPage(),
        'roles': (context) => RolesPage(),
        'client/products/list': (context) => ClientProductsListPage(),
        'restaurant/orders/list': (context) => RestaurantOrdersListPage(),
        'delivery/orders/list': (context) => DeliveryOrdersListPage(),
      },
      theme: ThemeData(
         primaryColor: MyColors.primaryColor
      ),
    );
  }
}