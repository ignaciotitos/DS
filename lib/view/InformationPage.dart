import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login/control/Controller.dart';

// Version con cupertino alert dialog
// Obtiene toda la informacion de la empresa del controlador
class InformationPage extends StatefulWidget {
  final Controller controller;

  const InformationPage({Key? key, required this.controller}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_formKey.currentState!.validate()) {
      final message = _messageController.text.trim();
      final userMail = widget.controller.getUserMail();
      // Aquí puedes agregar la lógica para enviar el mensaje por correo electrónico
      showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text('Pregunta enviada correctamente'),
          content: Text('Le responderemos en breve,  compruebe su correo ($userMail) para la respuesta.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _messageController.clear();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: Icon(
              Icons.business,
              size: 120,
              color: Colors.blue,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              widget.controller.empresa.nombre,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Quiénes somos?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  widget.controller.empresa.descripcion,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  '¿Dónde nos encontramos?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Encuentranos en : ${widget.controller.empresa.direccion}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  'Contacta con nosotros',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Nuestros datos de contacto son:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '${widget.controller.empresa.telefono} | ${widget.controller.empresa.email}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  'Haznos una pregunta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mensaje',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor, escriba su pregunta';
                      }
                      return null;
                    },
                    maxLines: null,
                    controller: _messageController,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: _sendMessage,
                    child: Text('Enviar mensaje'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/* v0 sin cupertinoAlertDialog
// Página que muestra la información de contacto de la tienda.
// Esta página siempre contendrá el mismo contenido; no requiere
// de controlador ni subclases puesto que la información de contacto
// de la empresa no debe cambiar

class InformationPage extends StatelessWidget {
  final Controller controller;

  const InformationPage({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 40),
            child: Icon(
              Icons.business,
              size: 120,
              color: Colors.blue,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              controller.empresa.nombre,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Quiénes somos?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  controller.empresa.descripcion,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  '¿Dónde nos encontramos?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Encuentranos en : ${controller.empresa.direccion}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  'Contacta con nosotros',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(
                  'Nuestros datos de contacto son:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  '${controller.empresa.telefono} | ${controller.empresa.email}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                Text(
                  'Haznos una pregunta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    hintText: controller.getNombre(),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Dirección de correo electrónico',
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mensaje',
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Enviar mensaje'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/
