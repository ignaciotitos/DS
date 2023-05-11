import 'package:login/model/Producto.dart';

class Usuario {
  String nombre;
  String email;
  String contrasena;
  String direccion;
  String telefono;
  // Historial de compras (no confundir compras con carrito;
  // el carrito lo maneja el controlador y es temporal;
  // sin embargo el historial de compras es estático
  List<Producto> _historialCompras = [];

  Usuario(
      this.nombre, this.email, this.contrasena, this.telefono, this.direccion);

  bool validarContrasena(String contrasena) {
    return this.contrasena == contrasena;
  }

  List<Producto> get historialCompras => _historialCompras;

  void comprar(Producto producto) {
    _historialCompras.add(producto);
  }
}
