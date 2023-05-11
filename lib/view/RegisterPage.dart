import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/control/Controller.dart';

class RegisterPage extends StatefulWidget {
  final Controller controller;
  RegisterPage({Key? key, required this.controller}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Para mostrar la alerta
  bool _isRegistered = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _phoneErrorText;
  String? _addressErrorText;
  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1/3,
          child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Regístrate',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre completo',
                    errorText: _nameErrorText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es requerido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    errorText: _emailErrorText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El correo electrónico es requerido';
                    }
                    if (!value.contains('@')) {
                      return 'Ingresa un correo electrónico válido';
                    } else if (!widget.controller.validarRegistroCorreo(value)) {
                      return 'Este correo ya está registrado';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    errorText: _passwordErrorText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La contraseña es requerido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Teléfono',
                    errorText: _phoneErrorText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El teléfono es requerido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    errorText: _addressErrorText,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'La dirección es requerida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final phone = _phoneController.text;
                      final address = _addressController.text;

                      widget.controller.registrarUsuario(name, email, password, phone, address);

                      await showDialog(
                        context: context,
                        builder: (_) => CupertinoAlertDialog(
                          title: Text('Usuario registrado correctamente'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        ),
                      );
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    }
                  },
                  child: Text('Registrarse'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}

/* v1 cupertino dialog
class RegisterPage extends StatefulWidget {
  final Controller controller;
  RegisterPage({Key? key, required this.controller}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _phoneErrorText;
  String? _addressErrorText;
  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Regístrate',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  errorText: _nameErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  errorText: _emailErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo electrónico es requerido';
                  }
                  if (!value.contains('@')) {
                    return 'Ingresa un correo electrónico válido';
                  } else if (!widget.controller.validarRegistroCorreo(value)) {
                    return 'Este correo ya está registrado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  errorText: _passwordErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  errorText: _phoneErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  errorText: _addressErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La dirección es requerida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final phone = _phoneController.text;
                    final address = _addressController.text;

                    widget.controller.registrarUsuario(name, email, password, phone, address);

                    await showDialog(
                      context: context,
                      builder: (_) => CupertinoAlertDialog(
                        title: Text('Usuario registrado correctamente'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          )
                        ],
                      ),
                    );
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }
                },
                child: Text('Registrarse'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
*/


/* Version sin CupertinoDialog
class RegisterPage extends StatefulWidget {
  final Controller controller;
  RegisterPage({Key? key, required this.controller}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameErrorText;
  String? _emailErrorText;
  String? _phoneErrorText;
  String? _addressErrorText;
  String? _passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Regístrate',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  errorText: _nameErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  errorText: _emailErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El correo electrónico es requerido';
                  }
                  if (!value.contains('@')) {
                    return 'Ingresa un correo electrónico válido';
                  } else if (!widget.controller.validarRegistroCorreo(value)) {
                    return 'Este correo ya está registrado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  errorText: _passwordErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La contraseña es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  errorText: _phoneErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es requerido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Dirección',
                  errorText: _addressErrorText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'La dirección es requerida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final name = _nameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final phone = _phoneController.text;
                    final address = _addressController.text;

                    widget.controller.registrarUsuario(name, email, password, phone, address);

                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/