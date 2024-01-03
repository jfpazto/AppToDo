import 'package:flutter/material.dart';
import 'package:finance_project/models/tag.dart';
import 'package:finance_project/models/Task.dart';
import 'package:finance_project/views/widgets/task_card.dart';
import 'package:finance_project/views/widgets/edit_task_dialog.dart';
import 'package:finance_project/views/tags_page.dart';

const DEFAULT_TASK_COLOR = Colors.yellow;//Constante para el color de las tareas
//StatefulWidget para la pagina de tareas, ya que se necesita que sea dinamica
class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();//Se crea el estado de la pagina
}

//State de la pagina de tareas
class _TasksPageState extends State<TasksPage> {
  //Se crean las listas de tareas y etiquetas
  List<TaskDto> tasks = List.generate(
    4,
    (index) => TaskDto(
        title: 'Task $index', color: DEFAULT_TASK_COLOR, fecha: DateTime.now()),
  );
  List<TagDto> tags = [
    TagDto(title: 'Tag 1', color: Colors.red, fecha: DateTime.now()),
    TagDto(title: 'Tag 2', color: Colors.blue, fecha: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(//Se crea el scaffold de la pagina, para poder agregar los elementos
      appBar: _buildAppBar(),//Se crea el appbar de la pagina
      body: _buildBody(),//Se crea el cuerpo de la pagina
      floatingActionButton: _buildFloatingActionButton(),//Se crea el boton flotante de la pagina
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,//Se define la posicion del boton flotante
      bottomNavigationBar: _buildBottomAppBar(),//Se crea el bottom app bar de la pagina
      endDrawer: _buildEndDrawer(),//Se crea el end drawer de la pagina, para las etiquetas
    );
  }

  //Metodo para crear el appbar de la pagina, que esta compuesto por un flexibleSpace, un titulo y un boton de menu
  AppBar _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(//flexibleSpace que es el fondo del appbar, para poder agregar un gradiente
        decoration: BoxDecoration(
          gradient: _buildGradient(),//Se crea el gradiente
        ),
      ),
      title: _buildShaderMask('Lista de Tareas'),//Se crea el shader mask para el titulo del appbar, shader mask es para poder agregar un gradiente al texto
      actions: <Widget>[
        Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  Padding _buildBody() {//Metodo para crear el cuerpo de la pagina
    return Padding(
      padding: const EdgeInsets.all(8.0),//EdgeInsets para agregar un padding a todos los elementos
      child: ListView.builder(
        itemCount: tasks.length,//itemCount es la cantidad de elementos que va a tener la lista
        itemBuilder: (context, index) {//itemBuilder es el metodo que se va a llamar para crear cada elemento de la lista
          return TaskCard(//Definicion del widget de la tareas
            task: tasks[index],
            onTap: () => _editTask(context, index),//Metodo para editar la tarea
          );
        },
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {//Metodo para crear el boton flotante de la pagina
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }
  //Metodo para crear el shader mask, que es para agregar un gradiente al texto
  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Drawer _buildEndDrawer() {
    return Drawer(
      child: TagsPage(),
    );
  }

  LinearGradient _buildGradient() {
    return LinearGradient(
      colors: [
        Color.fromARGB(255, 253, 163, 28),
        Color.fromARGB(255, 133, 132, 132)
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
  //Metodo para crear el shader mask, que es para agregar un gradiente al texto
  ShaderMask _buildShaderMask(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.topLeft,
        radius: 1.0,
        colors: <Color>[Colors.blue, Color.fromARGB(255, 236, 235, 235)],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: <Shadow>[
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            Shadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 8.0,
              color: Color.fromARGB(125, 0, 0, 255),
            ),
          ],
          fontFamily: 'YourCustomFont',
        ),
      ),
    );
  }

  //Metodo para editar la tarea
  Future<void> _editTask(BuildContext context, int index) async {
    final result = await showDialog<Map>(
      context: context,
      builder: (context) => EditTaskDialog(initialTask: tasks[index]),
    );
    if (result != null) {
      setState(() {
        tasks[index] = TaskDto(
          title: result['title'] as String,
          color: result['color'] as Color? ?? Colors.transparent,
          fecha: result['date'] as DateTime,
        );
      });
    }
  }
}