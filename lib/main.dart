import 'package:delivery_flutter/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_flutter/src/pages/login/login_page.dart';
import 'package:delivery_flutter/src/pages/register/register_page.dart';
import 'package:delivery_flutter/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

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
        'client/products/list': (context) => ClientProductsListPage(),
      },
      theme: ThemeData(
        //fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor
      ),
    );
  }
}