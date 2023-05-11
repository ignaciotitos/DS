import 'package:flutter/material.dart';
import 'package:login/control/Controller.dart';
import 'package:login/model/Producto.dart';

// Página incial, donde se muestra el catálogo de productos
// Se encargará de mostrar la lista de productos y asignarles
// una foto dependiendo del tipo (silla, mesa, sofá etc.)
class CatalogPage extends StatefulWidget {
  Controller controller;
  CatalogPage({required this.controller}) : super();
  @override
  _CatalogPageState createState() => _CatalogPageState(controller: controller);
}

// Clase que implementa el catálogo:
class _CatalogPageState extends State<CatalogPage> {
  Controller controller;
  _CatalogPageState({required this.controller}) : super();
  List<Producto> _productos = [];

  // Leemos el vector del controlador:
  @override
  void initState() {
    _productos = controller.getProductos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading:
            false, // Desactiva la flecha de retroceso
            title: const Text('Catálogo de muebles'),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 123, 191, 255)),
        // Separación por columnas:
        body: GridView.builder(
          // Número de muebles del catálogo:
          itemCount: _productos.length,
          // Tamaño y separación entre productos:
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 1.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetalleProducto(
                          producto: _productos[index],
                          controller: controller,
                          nombre: '${_productos[index].tipo.toString().split('.').last} ${_productos[index].color.toString().split('.').last}'
                              ' de ${_productos[index].material.toString().split('.').last}')),
                );
              },
              child: Column(
                  // Cada mueble (imagen + texto):
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(_productos[index].imagen,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      '${_productos[index].tipo.toString().split('.').last} de color ${_productos[index].color.toString().split('.').last}'
                      ' de ${_productos[index].material.toString().split('.').last}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
            );
          },
        ));
  }
}

// Clase que contiene la descripción de cada mueble:

class DetalleProducto extends StatelessWidget {
  Producto producto;
  Controller controller;
  String nombre;

  DetalleProducto({required this.producto, required this.controller, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Detalle del producto',
            style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('${nombre}',
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 91, 176, 255))),
        ),
        SizedBox(height: 15.0),
        Hero(
            tag: producto.imagen,
            child: Image.asset(producto.imagen,
                height: 150.0, width: 100.0, fit: BoxFit.contain)),
        SizedBox(height: 20.0),
        Center(
          child: Text(producto.precio.toString(),
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 91, 176, 255))),
        ),
        SizedBox(height: 10.0),
        Center(
          child: Text(nombre,
              style: TextStyle(
                  color: Color.fromARGB(255, 91, 176, 255),
                  fontFamily: 'Varela',
                  fontSize: 24.0)),
        ),
        SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text(
                'Disponemos de muebles de alta calidad, incluyendo sillas, mesas y armarios, todos ellos hechos a mano con materiales de la mejor calidad. Ofrecemos una amplia gama de colores para nuestros muebles, que incluyen el clásico marrón de la madera natural, así como opciones modernas y elegantes como blanco y negro.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Varela',
                    fontSize: 19.0,
                    color: Color(0xFFB4B8B9))),
          ),
        ),
        SizedBox(height: 20.0),
        Center(
          child: InkWell(
            onTap: (){
              controller.agregarAlCarrito(producto);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Producto añadido al carrito'))
              );
            },
          child: Container(
              width: MediaQuery.of(context).size.width - 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color.fromARGB(255, 91, 176, 255)),
              child: Center(
                  child: Text(
                    'Añadir al carrito',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )))
          )
            )
      ]),
    );
  }
}
