import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'tasks_page.dart';
class LoginPage extends StatefulWidget { //Clase que hereda de StatefulWidget
  @override
  _LoginPageState createState() => _LoginPageState(); //Sobreescribe el metodo createState()
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();//GlobalKey es una clave que identifica unívocamente los widgets

  @override
  Widget build(BuildContext context) {
    return Scaffold( //Scaffold es un widget que implementa la estructura básica de una pantalla
      body: Container(//Container es un widget que permite definir un área rectangular con un color de fondo
        height: MediaQuery.of(context).size.height,//MediaQuery.of(context).size.height es el alto de la pantalla, context es el contexto actual
        decoration: _buildGradientDecoration(),//Aqui se llama a la funcion que se creo abajo, la cual retorna un BoxDecoration
        child: SingleChildScrollView(//SingleChildScrollView es un widget que permite hacer scroll
          child: Form(//Form es un widget que permite definir un formulario
            key: _formKey,//Aqui se le asigna la clave que se creo arriba, porque el formulario necesita una clave para identificarlo, se crea aqui porque es un estado
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,//crossAxisAlignment es un atributo que permite definir la alineación de los hijos en el eje transversal, start es para que se alineen a la izquierda
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
    return BoxDecoration(//BoxDecoration es un widget que permite definir una caja decorada
      gradient: LinearGradient(//LinearGradient es un widget que permite definir un gradiente lineal, un gradiente es una transición gradual entre dos o más colores
        begin: Alignment.topRight,//Alignment es un widget que permite definir la alineación de un widget hijo dentro de un widget padre, topRight es para que el gradiente empiece en la esquina superior derecha
        end: Alignment.bottomLeft,//bottomLeft es para que el gradiente termine en la esquina inferior izquierda
        colors: [Color.fromARGB(255, 243, 159, 33), Color.fromARGB(255, 252, 249, 249)],
      ),
    );
  }

  Widget _buildLoginHeader() {
    return Column(
      children: [
        SizedBox(height: 50.0),//SizedBox es un widget que permite definir un espacio vacío
        Center(//Center es un widget que permite centrar a sus hijos
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
    return Padding(//Padding es un widget que permite definir un espacio vacío
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),//EdgeInsets es un widget que permite definir un espacio vacío
      child: TextFormField(//TextFormField es un widget que permite definir un campo de texto
        decoration: InputDecoration(
          labelText: 'Nombre de usuario',
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(//UnderlineInputBorder es un widget que permite definir un borde subrayado
            borderSide: BorderSide(color: Color.fromARGB(255, 253, 175, 8)),
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
        validator: (value) {//validator es un atributo que permite definir una función que valida el valor del campo de texto posteriormente en el validate() del formulario
          if (value == null || value.isEmpty) {
            return 'Por favor ingresa tu contraseña';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(//Center es un widget que permite centrar a sus hijos
      heightFactor: 2.0,//heightFactor es un atributo que permite definir el factor de escala vertical, escala vertical es el tamaño de la caja
      child: ElevatedButton(//ElevatedButton es un widget que permite definir un botón, elevated es para que el botón tenga un efecto de elevación
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {//_formKey.currentState?.validate() ?? false es una expresión que valida el formulario, si el formulario es válido, se ejecuta el código, currentState es el estado actual del formulario, se refiere a la instancia de FormState que se crea cuando se crea el formulario, validate() es una función que valida el formulario
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Procesando Datos')),
            );
            Navigator.push(//Navigator es un widget que permite navegar entre pantallas
              context,//context es el contexto actual, contexto actual se refiere a la instancia de BuildContext que se crea cuando se crea el widget
              MaterialPageRoute(//MaterialPageRoute es un widget que permite definir una ruta de material
                builder: (context) => TasksPage(),    //builder es un atributo que permite definir una función que crea el widget que se va a mostrar en la pantalla
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,//mainAxisAlignment es un atributo que permite definir la alineación de los hijos en el eje principal, spaceEvenly es para que los hijos se distribuyan uniformemente en el eje principal
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
