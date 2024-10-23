import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:traductor_biblico/pages/login_page.dart';

import '../models/user.dart';
import '../repository/firebase_api.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  //Variables para el registro del usuario
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _reppassword = TextEditingController();

  //Función para mostrar un mensaje de alerta si las dos contraseñas no coinciden
  void _showMsg(String msg) {
    final Scaffold = ScaffoldMessenger.of(context);
    Scaffold.showSnackBar(SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Aceptar',
        onPressed: Scaffold.hideCurrentSnackBar,
      ),
    ));
  }

  //Fnción para guardar el usuario en preferencias compartidas
  void saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user));
    //var result = await _firebaseApi.registerUser(user.email, user.password);
  }

  //función al momento de oprimir el boton de registro
  void _onRegisterButtonClicked() {
    setState(() {
      // verificamos si los campos de contraseña coinciden y si es el caso, creamos un objeto de la clase User
      // y lo guardamos en preferencias compartidas
      if (_password.text == _reppassword.text) {
        var user = User(_email.text, _password.text);
        saveUser(user);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        _showMsg("Las constraseñas deben ser iguales");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8, vertical: 16), // 'margenes' de la pagina
          child: Center(
            // widget para que se pueda hacer scroll en la pagina
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, //para centrar el contenido
                // Children con el formulario de registro
                children: <Widget>[
                  const Image(
                    // Visualización del logo de la app
                    image: AssetImage('assets/images/logo.png'),
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Campo de Correo electrónico
                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ('Correo electrónico'),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  //Campo de Contraseña
                  TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ('Contraseña'),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Campo para que repita su contraseña
                  TextFormField(
                    controller: _reppassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ('Repita su contraseña'),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  // Botón para registrar el formulario de registro
                  ElevatedButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 16)),
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: const Text("Registrar"),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
