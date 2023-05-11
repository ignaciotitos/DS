import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:login/model/Usuario.dart';
import 'package:login/model/Producto.dart';
import 'package:login/model/Material.dart';
import 'package:login/model/TipoMueble.dart';
import 'package:login/model/ColorMueble.dart';
import 'package:login/model/Empresa.dart';

// Para el programa, utilizaremos un controlador global que
// gestione todos los datos de manera centralizada, puesto que
// los datos tienen relación entre sí.
// Para ello todas las páginas compartirán el mismo controlador

class Controller with ChangeNotifier{
  // Lista de usuarios registrados
  List<Usuario> _usuarios = [];
  List<Producto> _productos = []; // Lista de productos
  List<Producto> _carrito = [];
  final Empresa _empresa = new Empresa();

  Usuario? _usuarioActual = null; // Usuario actual del sistema
  Empresa get empresa => _empresa;

  Controller() {
    this._inicializar();
  }

  // Método para agregar un nuevo usuario
  void agregarUsuario(Usuario usuario) {
    _usuarios.add(usuario);
  }

  // Método para agregar un nuevo producto
  void agregarProducto(Producto producto) {
    _productos.add(producto);
  }

  void agregarAlCarrito(Producto producto) {
    _carrito.add(producto);
  }

  void vaciarCarrito() {
    _carrito.clear();
  }

  // Método para verificar si el usuario y la contraseña son válidos
  bool iniciarSesion(String email, String contrasena) {
    bool inicio;
    int idx = _usuarios.indexWhere((usuario) => usuario.email == email && usuario.contrasena == contrasena);

    if(idx==-1) {
      _usuarioActual = null;
      inicio= false;
    } else {
      _usuarioActual = _usuarios[idx];
      inicio=true;
    }

    return inicio;
  }

  Usuario? get usuarioActual => _usuarioActual;

  void cerrarSesion() {
    _usuarioActual = null;
  }

  // Devuelve true si el correo no está registrado aún
  bool validarRegistroCorreo(String value) {
    return !_usuarios.any((usuario) => usuario.email == value);
  }

  void registrarUsuario(String nombre, String email, String contrasena, String telefono, String direccion) {
    agregarUsuario(new Usuario(nombre,email,contrasena, telefono, direccion));
  }

  /*A continuación hay una serie de métodos usados para obtener los
  datos del usuario. Esto se hace así para respetar la jerarquía
  entre vista, modelo y controlador. */

  String getUserName() {
    return _usuarioActual!.nombre;
  }

  String getUserMail() {
    return _usuarioActual!.email;
  }

  String getUserAdress() {
    return _usuarioActual!.direccion;
  }

  String getUserPhone() {
    return _usuarioActual!.telefono;
  }

  //Métodos para editar los datos del usuario actual:

  void setUserName(String name) {
    _usuarioActual!.nombre = name;
  }

  void setUserMail(String mail) {
    _usuarioActual!.email = mail;
  }

  void setUserAdress(String direction) {
    _usuarioActual!.direccion = direction;
  }

  void setUserPhone(String phone) {
    _usuarioActual!.telefono = phone;
  }

  void setUserPassword(String pass) {
    _usuarioActual!.contrasena = pass;
  }

  //Método usado para comparar contraseñas antes de modificar datos:
  bool comparePassword(String pass) {
    return (pass == _usuarioActual!.contrasena);
  }

  // Simula la información obtenida de la BD
  void _inicializar() {
    // Crea los usuarios
    agregarUsuario(
        Usuario("Antonio López", "user1.com", "1", "600600601", "calle A"));
    agregarUsuario(
        Usuario("Lucía Muñoz", "user2.com", "2", "600600602", "calle B"));
    agregarUsuario(
        Usuario("María Fernandez", "user3.com", "3", "600600603", "calle C"));
    agregarUsuario(
        Usuario("Felipe Mendoza", "user4.com", "4", "600600604", "calle D"));

    // Añadimos muebles de madera:
    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.madera, ColorMueble.marron, ""));
    agregarProducto(Producto(
        300, TipoMueble.Mesa, Material.madera, ColorMueble.marron, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.madera, ColorMueble.marron, ""));

    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.madera, ColorMueble.blanco, ""));
    agregarProducto(Producto(
        300, TipoMueble.Mesa, Material.madera, ColorMueble.blanco, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.madera, ColorMueble.blanco, ""));

    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.madera, ColorMueble.negro, ""));
    agregarProducto(
        Producto(300, TipoMueble.Mesa, Material.madera, ColorMueble.negro, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.madera, ColorMueble.negro, ""));

    // Añadimos muebles de porcelana:
    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.porcelana, ColorMueble.marron, ""));
    agregarProducto(Producto(
        300, TipoMueble.Mesa, Material.porcelana, ColorMueble.marron, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.porcelana, ColorMueble.marron, ""));

    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.porcelana, ColorMueble.blanco, ""));
    agregarProducto(Producto(
        300, TipoMueble.Mesa, Material.porcelana, ColorMueble.blanco, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.porcelana, ColorMueble.blanco, ""));

    agregarProducto(Producto(
        100, TipoMueble.Silla, Material.porcelana, ColorMueble.negro, ""));
    agregarProducto(Producto(
        300, TipoMueble.Mesa, Material.porcelana, ColorMueble.negro, ""));
    agregarProducto(Producto(
        500, TipoMueble.Armario, Material.porcelana, ColorMueble.negro, ""));

    // Añadimos al carrito:
    agregarAlCarrito(Producto(
        100, TipoMueble.Silla, Material.madera, ColorMueble.marron, ""));
    agregarAlCarrito(Producto(
        300, TipoMueble.Mesa, Material.madera, ColorMueble.marron, ""));
  }

  // Añadido:
  List<Producto> getProductos() {
    return _productos;
  }

  List<Usuario> getUsuarios() {
    return _usuarios;
  }

  Producto getProducto(int num){

    return _carrito[num];
  }

  List<Producto> getCarrito(){

    return _carrito;
  }
}
