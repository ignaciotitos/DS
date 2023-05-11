import 'package:login/model/Material.dart';
import 'package:login/model/TipoMueble.dart';
import 'package:login/model/ColorMueble.dart';

// Estructura que representa los productos de la tienda
// Los datos TipoMueble Material y ColorMueble son enumerados
// El identificador es UNICO y autoincremental
class Producto {
  // Atributos
  static int _nextId = 1; // Atributo de clase para el id autoincremental
  late int _id;
  double _precio;
  TipoMueble _tipo;
  Material _material;
  ColorMueble _color;
  late String _imagen;
  String _descripcion = '';

  // Constructor
  Producto(this._precio, this._tipo, this._material, this._color,
      this._descripcion) {
    this._id = _nextId;
    _nextId++;
    this._imagen = "assets/" +
        tipo.toString().split('.').last +
        "-" +
        material.toString().split('.').last +
        "-" +
        color.toString().split('.').last +
        ".png";
  }

  // Getters y Setters
  int get id => _id;

  double get precio => _precio;

  String get descripcion => _descripcion;

  String get imagen => _imagen;

  set precio(double value) {
    _precio = value;
  }

  TipoMueble get tipo => _tipo;

  set tipo(TipoMueble value) {
    _tipo = value;
  }

  Material get material => _material;

  set material(Material value) {
    _material = value;
  }

  ColorMueble get color => _color;

  set color(ColorMueble value) {
    _color = value;
  }
}
