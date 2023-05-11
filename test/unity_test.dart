
import 'package:flutter_test/flutter_test.dart';

// Añadir aquí clases del programa que vayan a ser probadas
import 'package:login/control/Controller.dart';
import 'package:login/model/Producto.dart';
import 'package:login/model/Usuario.dart';
import 'package:login/model/TipoMueble.dart';
import 'package:login/model/ColorMueble.dart';
import 'package:login/model/Material.dart';


// Archivo de tests
void main() {
  group('pruebas de unidad: Usuario', () {
    test('Validar contrasena exitoso', () {
      final usuario = Usuario('John Doe', 'john.doe@example.com', '123456', '123456789', '123 Main St');
      expect(usuario.validarContrasena('123456'), true);
    });

    test('Validar contrasena fallido', () {
      final usuario = Usuario('John Doe', 'john.doe@example.com', '123456', '123456789', '123 Main St');
      expect(usuario.validarContrasena('123'), false);
    });

    test('Comprar un producto exitoso', () {
      final producto = Producto(100.0, TipoMueble.Silla, Material.porcelana, ColorMueble.negro, "");
      final usuario = Usuario('John Doe', 'john.doe@example.com', '123456', '123456789', '123 Main St');
      usuario.comprar(producto);
      expect(usuario.historialCompras.length, 1);
      expect(usuario.historialCompras[0], producto);
    });

    test('Comprar varios productos exitoso', () {
      final producto1 = Producto(100.0, TipoMueble.Silla, Material.madera, ColorMueble.negro, "");
      final producto2 = Producto(200.0, TipoMueble.Mesa, Material.cuero, ColorMueble.blanco, "");
      final usuario = Usuario('John Doe', 'john.doe@example.com', '123456', '123456789', '123 Main St');
      usuario.comprar(producto1);
      usuario.comprar(producto2);
      expect(usuario.historialCompras.length, 2);
      expect(usuario.historialCompras.contains(producto1), true);
      expect(usuario.historialCompras.contains(producto2), true);
    });
  });

  group('pruebas de unidad: Producto', () {
    test('Crear un producto con atributos válidos', () {
      Producto producto = Producto(100.0, TipoMueble.Mesa, Material.madera, ColorMueble.negro, "descripcion");
      expect(producto.id, isNotNull);
      expect(producto.precio, equals(100.0));
      expect(producto.tipo, equals(TipoMueble.Mesa));
      expect(producto.material, equals(Material.madera));
      expect(producto.color, equals(ColorMueble.negro));
    });

    test('Modificar el precio de un producto', () {
      Producto producto = Producto(100.0, TipoMueble.Mesa, Material.madera, ColorMueble.negro, "descripcion");
      producto.precio = 150.0;
      expect(producto.precio, equals(150.0));
    });

    test('Modificar el tipo de un producto', () {
      Producto producto = Producto(100.0, TipoMueble.Mesa, Material.madera, ColorMueble.negro, "descripcion");
      producto.tipo = TipoMueble.Silla;
      expect(producto.tipo, equals(TipoMueble.Silla));
    });

    test('Modificar el material de un producto', () {
      Producto producto = Producto(100.0, TipoMueble.Mesa, Material.madera, ColorMueble.negro, "descripcion");
      producto.material = Material.cuero;
      expect(producto.material, equals(Material.cuero));
    });

    test('Modificar el color de un producto', () {
      Producto producto = Producto(100.0, TipoMueble.Mesa, Material.madera, ColorMueble.negro, "descripcion");
      producto.color = ColorMueble.blanco;
      expect(producto.color, equals(ColorMueble.blanco));
    });
  });

  group('pruebas de unidad: Controller', () {
    Controller controller = Controller();

    test('Añadir un nuevo usuario', () {
      Usuario user = Usuario('Test User', 'testuser@test.com', 'test123', '111111111', 'Test address');
      controller.agregarUsuario(user);
      expect(controller.usuarioActual, isNull);
      expect(controller.getUsuarios(), contains(user));
    });

    test('Añadir un nuevo producto', () {
      Producto product = Producto(200, TipoMueble.Silla, Material.metal, ColorMueble.negro, '');
      controller.agregarProducto(product);
      expect(controller.getProductos(), contains(product));
    });

    test('Iniciar sesion con credenciales válidas', () {
      String email = 'user1.com';
      String password = '1';
      bool result = controller.iniciarSesion(email, password);
      expect(result, isTrue);
      expect(controller.getUserMail(), equals(email));
    });

    test('Iniciar sesion con credenciales inválidas', () {
      String email = 'nonexistentuser@test.com';
      String password = 'test123';
      bool result = controller.iniciarSesion(email, password);
      expect(result, isFalse);
      expect(controller.usuarioActual, isNull);
    });

    test('Cerrar sesion', () {
      controller.cerrarSesion();
      expect(controller.usuarioActual, isNull);
    });
  });

}