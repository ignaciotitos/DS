import 'package:flutter/material.dart';
import 'package:login/view/LoginPage.dart';
import 'package:login/control/Controller.dart';

// Página que muestra la información del usuario actual.
// Permite además modificar los metadatos menos relevantes
// como son el teléfono y la dirección

class ProfilePage extends StatefulWidget {
  Controller controller;

  ProfilePage({super.key, required this.controller});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //Métodos usados para modificar los datos del usuario:
  void _cambiarNombre(Controller controller, BuildContext context) {
    String nuevo = "";

    intro_datos(context).then((value) {
      nuevo = value;

      setState(() {
        if (nuevo != "") {
          controller.setUserName(nuevo);
        }
      });
    });
  }

  void _cambiarCorreo(Controller controller, BuildContext context) {
    String nuevo = "";

    intro_datos(context).then((value) {
      nuevo = value;

      setState(() {
        if (nuevo != "") {
          controller.setUserMail(nuevo);
        }
      });
    });
  }

  void _cambiarDireccion(Controller controller, BuildContext context) {
    String nuevo = "";

    intro_datos(context).then((value) {
      nuevo = value;

      setState(() {
        if (nuevo != "") {
          controller.setUserAdress(nuevo);
        }
      });
    });
  }

  void _cambiarTelefono(Controller controller, BuildContext context) {
    String nuevo = "";

    intro_datos(context).then((value) {
      nuevo = value;

      setState(() {
        if (nuevo != "") {
          controller.setUserPhone(nuevo);
        }
      });
    });
  }

  void _cambiarContrasena(Controller controller, BuildContext context) {
    String anterior = "";
    String nuevo = "";

    _solicitarContrasena(context).then((value) {
      anterior = value;

      if(controller.comparePassword(anterior)) {
        intro_datos(context).then((value){
          nuevo = value;

          controller.setUserPassword(nuevo);
        });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Contraseña incorrecta"),
                actions: <Widget> [
                  TextButton(
                      child: Text("Cerrar"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                  )
                ],
              );
            }
        );
      }
    });
  }

  //Método usado para solicitar la contraseña del usuario antes de modificar datos sensibles.
  Future<String> _solicitarContrasena (BuildContext context) async {
    String pass = "";
    TextEditingController _entrada = TextEditingController();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Introduzca su actual contraseña: "),
            content: TextField(
                controller: _entrada
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("Enviar"),
                  onPressed: () {
                    pass = _entrada.text;
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        }
    );

    return pass;
  }

  //Método usados para recoger los datos que el cliente introduce
  Future<String> intro_datos(BuildContext context) async {
    String datos = "";
    TextEditingController _entrada = TextEditingController();

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Introduzca los nuevos datos: "),
            content: TextField(
              controller: _entrada,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancelar"),
                onPressed: () {
                  _entrada.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Confirmar"),
                onPressed: () {
                  datos = _entrada.text;
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    return datos;
  }

  //Método usado para mostrar una notificación explicando que hace cada botón.
  void _informacion(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Este botón sirve para modificar al campo al que acompaña"),
          duration: Duration(seconds: 2),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
        false, // Desactiva la flecha de retroceso
        title: Text('Información de la cuenta'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 123, 191, 255),
        leading: const Icon(Icons.account_circle_rounded, color: Colors.white,),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 30),
        children: [
          ListTile(
            title: Row(
              children: [
                Text("Nombre: "),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {_cambiarNombre(widget.controller, context);},
                  onLongPress: () {_informacion(context);},
                  child: Icon(Icons.add_box_outlined, size: 20),
                )
              ],
            ),
            subtitle: Text(widget.controller.getUserName()),
            leading: Icon(Icons.person),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Row(
              children: [
                Text("Correo: "),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {_cambiarCorreo(widget.controller, context);},
                  onLongPress: () {_informacion(context);},
                  child: Icon(Icons.add_box_outlined, size: 20),
                )
              ],
            ),
            subtitle: Text(widget.controller.getUserMail()),
            leading: Icon(Icons.mail),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Row(
              children: [
                Text("Dirección: "),
                SizedBox(width: 10),
                InkWell(
                    onTap: () {_cambiarDireccion(widget.controller, context);},
                    onLongPress: () {_informacion(context);},
                    child: Icon(Icons.add_home, size: 20)
                )
              ],
            ),
            subtitle: Text(widget.controller.getUserAdress()),
            leading: Icon(Icons.home),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Row(
              children: [
                Text("Teléfono: "),
                SizedBox(width: 10),
                InkWell(
                    onTap: (){_cambiarTelefono(widget.controller, context);},
                    onLongPress: () {_informacion(context);},
                    child: Icon(Icons.add_call, size: 20)
                )
              ],
            ),
            subtitle: Text(widget.controller.getUserPhone()),
            leading: Icon(Icons.phone),
          ),
          SizedBox(height: 20),
          ListTile(
              title: Row(
                children: [
                  Text("Contraseña"),
                  SizedBox(width: 10),
                  InkWell(
                      onTap: () {_cambiarContrasena(widget.controller, context);},
                      onLongPress: () {_informacion(context);},
                      child: Icon(Icons.add_box_outlined, size: 20)
                  )
                ],
              ),
              leading: Icon(Icons.key)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.controller.cerrarSesion();
          // Al hacer clic en el botón cerrar sesión, se redirige a la página de inicio de sesión
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(controller: widget.controller)),
                  (Route<dynamic> route) => false);
        },
        tooltip: 'Cerrar sesión',
        child: const Icon(Icons.logout),
      ),
    );
  }
}