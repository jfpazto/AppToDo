import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'tasks_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: _buildGradientDecoration(),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildLoginHeader(),//Aqui se llama a la funcion que se creo abajo
                _buildUsernameField(),
                _buildPasswordField(),
                _buildLoginButton(context),
                _buildSocialLoginButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildGradientDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue, Color.fromARGB(255, 252, 249, 249)],
      ),
    );
  }

  Widget _buildLoginHeader() {
    return Column(
      children: [
        SizedBox(height: 50.0),
        Center(
          child: Text(
            'Iniciar sesión',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: <Shadow>[
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 116, 114, 114),
                ),
              ],
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
              decorationStyle: TextDecorationStyle.dotted,
              decorationThickness: 2.0,
              letterSpacing: 2.0,
              wordSpacing: 2.0,
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 50.0),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'Nombre de usuario',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa tu nombre de usuario';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: 'Contraseña',
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa tu contraseña';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      heightFactor: 2.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Procesando Datos')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TasksPage(),
              ),
            );
          }
        },
        child: Text('Iniciar sesión'),
      ),
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildSocialButton(
          FontAwesomeIcons.google,
          'Google',
          Colors.red,
          () {
            // Aquí va tu código para iniciar sesión con Google
          },
        ),
        _buildSocialButton(
          FontAwesomeIcons.apple,
          'Apple',
          Colors.black,
          () {
            // Aquí va tu código para iniciar sesión con Apple
          },
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      IconData icon, String label, Color color, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          icon: Icon(icon, color: Colors.white),
          label: Text(label, style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
