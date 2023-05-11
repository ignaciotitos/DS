import 'package:flutter/material.dart';
import 'package:login/control/Controller.dart';
import 'package:login/model/ColorMueble.dart';
import 'package:login/model/Material.dart';
import 'package:login/model/TipoMueble.dart';

import '../model/Producto.dart';

// Página que muestra el carrito actual (productos seleccionados
// por el usuario actual) y que aún no han sido comprados.
// Debe de mostrar el array de productos y el precio total.
// Además debe de permitir la opción de comprar o vaciar.
class ShoppingCartPage extends StatefulWidget {
  Controller controller;
  ShoppingCartPage({Key? key,required this.controller}) : super(key: key);

  @override
  _SillaViewState createState()=> _SillaViewState();

/*
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Shopping Cart Page',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

   */
}

class _SillaViewState extends State<ShoppingCartPage> {
  List<Producto> estado = [];

  void initState(){
    super.initState();
    estado= widget.controller.getCarrito();

    widget.controller.addListener((){
      setState(() {
        estado=widget.controller.getCarrito();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Desactiva la flecha de retroceso
          title: const Text('Carrito de la compra'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 123, 191, 255)),
      body: ListView.builder(
          itemCount: widget.controller.getCarrito().length,
          itemBuilder: (context, index){
            final MuebleManager lista= MuebleManager(widget.controller.getProducto(index));
            return ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
              leading: Image.asset(lista._producto.imagen),
              title: Text("Mueble "+ (index +1).toString()),
              subtitle: lista.generateText(),
            );
          }),
    );
    throw UnimplementedError();
  }
}

class MuebleManager{
  Producto _producto;
  MuebleManager(this._producto);

  Icon generateIcon(){
    Icon aux;
    if(_producto.tipo.toString() == "sofa"){
      aux= Icon(Icons.chair_rounded,size: 80.0,color: Colors.black );
    }else if(_producto.tipo.toString() == "armario"){
      aux= Icon(Icons.satellite_rounded,size: 80.0,color: Colors.black);
    }else if(_producto.tipo.toString() == "mesa"){
      aux= Icon(Icons.table_bar_rounded,size: 80.0,color: Colors.black);
    }else{
      aux= aux= Icon(Icons.chair_rounded,size: 80.0,color: Colors.black );
    }

    return aux;
  }

  Text generateText(){
    String cadena= "\nTipo: \t "+_producto.tipo.toString().replaceRange(0, 11, " ") +"\nmaterial "+_producto.material.toString().replaceRange(0, 9, " ")+
        "\nColor: \t "+_producto.color.toString().replaceRange(0, 12, " ")+"\nprecio \t "+_producto.precio.toString();
    return Text(cadena);
  }
}