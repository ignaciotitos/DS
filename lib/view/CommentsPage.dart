import 'package:flutter/material.dart';
import 'package:login/model/Comentario.dart';
import 'package:login/control/Controller.dart';
import 'package:login/model/Usuario.dart';

// Hemos agregado la libre intl para poder formatear la fecha y hora de los comentarios.
// flutter pub add intl
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  Controller controller;
  CommentPage({required this.controller}) : super();

  @override
  _ComentariosPageState createState() => _ComentariosPageState(controller: controller);
}

class _ComentariosPageState extends State<CommentPage> {
  Controller controller;
  _ComentariosPageState({required this.controller}) : super();

  final _formKey = GlobalKey<FormState>();
  final _comentarioController = TextEditingController();
  List<Comment> _comentarios = [
    // Agregamos dos comentarios por defecto.
    Comment(
        usuario: 'Carlos Muñoz',
        comentario:
            'He pedido una silla de madera blanca y es de muy buena calidad.',
        fecha: DateTime(2023, 3, 22, 18, 56)),

    Comment(
        usuario: 'Elena Sánchez',
        comentario:
            'Sin duda, los mejores muebles que he comprado nunca. ¡Qué calidad!',
        fecha: DateTime(2023, 4, 3, 14, 34))
  ];

  @override
  void dispose() {
    _comentarioController.dispose();
    super.dispose();
  }

  // Función encargada de enviar un comentario una vez se pulsa el botón.
  void _enviarComentario() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final usuario = controller.getUserName();
        final comment = Comment(
          usuario: usuario,
          comentario: _comentarioController.text,
          fecha: DateTime.now(),
        );
        _comentarios.add(comment);
      });

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading:
          false, // Desactiva la flecha de retroceso
          title: Text('Valoraciones de los muebles'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 123, 191, 255)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _comentarioController,
                decoration: InputDecoration(
                  labelText: 'Escriba un comentario',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, escriba un comentario';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _enviarComentario,
                child: Text('Enviar comentario'),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _comentarios.length,
                  itemBuilder: (BuildContext context, int index) {
                    final comment = _comentarios[index];
                    // Para poner el formato que queremos en la fecha.
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm').format(comment.fecha);
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(131, 182, 219, 255),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comment.usuario,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text(formattedDate.toString(),
                              style: TextStyle(fontSize: 16.0)),
                          SizedBox(height: 10),
                          Text(comment.comentario,
                              style: TextStyle(fontSize: 18.0)),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
