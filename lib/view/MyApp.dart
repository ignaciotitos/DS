import 'package:flutter/material.dart';
import 'package:login/view/LoginPage.dart';
import 'package:login/view/ShopPage.dart';
import 'package:login/view/RegisterPage.dart';
import 'package:login/control/Controller.dart';

class MyApp extends StatelessWidget {
  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(controller: controller,),
        '/registro': (context) => RegisterPage(controller: controller,),
        '/catalogo': (context) => ShopPage(controller: controller,),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}