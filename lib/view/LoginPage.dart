import 'package:flutter/material.dart';
import 'package:login/control/Controller.dart';

class LoginPage extends StatefulWidget {
  final Controller controller;
  LoginPage({Key? key, required this.controller}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  String? _emailErrorText;
  String? _contrasenaErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar sesión'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: _emailErrorText,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El email es requerido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: _contrasenaController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        errorText: _contrasenaErrorText,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La contraseña es requerida';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final email = _emailController.text;
                          final contrasena = _contrasenaController.text;
                          final usuarioValido = widget.controller.iniciarSesion(email, contrasena);
                          if (usuarioValido) {
                            Navigator.pushNamed(context, '/catalogo');
                          } else {
                            setState(() {
                              _emailErrorText = 'El email o la contraseña no son válidos';
                              _contrasenaErrorText = 'El email o la contraseña no son válidos';
                            });
                          }
                        }
                      },
                      child: Text('Iniciar sesión'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registro');
                },
                child: Text(
                  '¿No tienes una cuenta? Regístrate',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
