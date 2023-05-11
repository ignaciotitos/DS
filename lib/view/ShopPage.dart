import 'package:flutter/material.dart';
import 'package:login/view/ProfilePage.dart';
import 'package:login/view/ShoppingCartPage.dart';
import 'package:login/view/CatalogPage.dart';
import 'package:login/view/InformationPage.dart';
import 'package:login/view/CommentsPage.dart';
import 'package:login/control/Controller.dart';

// Página principal de la tienda, contiene BottomNavBar y permite
// moverse entre las diferentes páginas de la aplicación. Sólo se
// puede acceder a esta si se inicia sesión previamente.
class ShopPage extends StatefulWidget {
  Controller controller;
  ShopPage({Key? key,required this.controller}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      CatalogPage(controller: widget.controller),
      ShoppingCartPage(controller: widget.controller),
      CommentPage(controller: widget.controller),
      InformationPage(controller: widget.controller),
      ProfilePage(controller: widget.controller),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Establece en false para ocultar la flecha de retroceso
        title: const Text('Tienda de Muebles'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Mi cesta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_rounded),
            label: 'Valoraciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_rounded),
            label: 'Quienes Somos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi Perfil',
          ),
        ],
      ),
    );
  }
}