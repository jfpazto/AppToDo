import 'package:finance_project/widgets/add_tag_dialog.dart';
import 'package:flutter/material.dart';
import 'package:finance_project/widgets/tag.dart';
import 'package:finance_project/widgets/Task.dart';
import 'package:finance_project/widgets/task_card.dart';
import 'package:finance_project/widgets/edit_task_dialog.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

const DEFAULT_TASK_COLOR = Colors.yellow;
List<Tag> tags = [
  Tag(title: 'Tag 1', color: Colors.red, fecha: DateTime.now()),
  Tag(title: 'Tag 2', color: Colors.blue, fecha: DateTime.now()),
  // Agrega más tags aquí
];

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // Aquí puedes definir la lista de tareas
  List<Task> tasks = List.generate(
    4,
    (index) => Task(
        title: 'Task $index', color: DEFAULT_TASK_COLOR, fecha: DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 253, 163, 28), Color.fromARGB(255, 133, 132, 132)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => RadialGradient(
            center: Alignment.topLeft,
            radius: 1.0,
            colors: <Color>[Colors.blue, Color.fromARGB(255, 236, 235, 235)],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: Text(
            'Lista de Tareas',
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
              fontFamily: 'YourCustomFont', // replace with your custom font
            ),
          ),
        ),
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
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskCard(
              task: tasks[index],
              onTap: () => _editTask(context, index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes manejar la acción de agregar una nueva tarea
          // Por ejemplo, puedes mostrar un diálogo para ingresar la nueva tarea
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(
                    context); // Esto te llevará a la página anterior, que puede ser tu página de inicio
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 100, // You can adjust this value to change the height of the header
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 253, 163, 28), Color.fromARGB(255, 133, 132, 132)], // Gradient color
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[Colors.blue, Color.fromARGB(255, 236, 235, 235)],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  child: Text(
                    'ETIQUETAS',
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
                      fontFamily: 'YourCustomFont', // replace with your custom font
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  onPressed: () {
                    _addTag(context);
                  },
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
                ),
              ),
            ),
            SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tags[index].title),
                    onTap: () {
                      _editTag(context, index);
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteTag(index);
                      },
                    ),
                  );
                },
              ),
            ),
            // Aquí puedes agregar más widgets si los necesitas
          ],
        ),
      ),
    );
  }

  Future<void> _editTask(BuildContext context, int index) async {
    final result = await showDialog<Map>(
      context: context,
      builder: (context) => EditTaskDialog(initialTask: tasks[index]),
    );
    if (result != null) {
      setState(() {
        tasks[index] = Task(
          title: result['title'] as String,
          color: result['color'] as Color? ?? Colors.transparent,
          fecha: result['date'] as DateTime,
        );
      });
    }
  }



// ...

  Future<void> _editTag(BuildContext context, int index) async {
    Color pickerColor = tags[index].color;
    final newColor = await showDialog<Color>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (color) {
                pickerColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop(pickerColor);
              },
            ),
          ],
        );
      },
    );
    if (newColor != null) {
      setState(() {
        tags[index] = Tag(
          title: tags[index].title,
          color: newColor,
          fecha: tags[index].fecha,
        );
      });
    }
  }

  Future<void> _addTag(BuildContext context) async {
    final result = await showDialog<Map>(
      context: context,
      builder: (context) => AddTagDialog(
          initialTask: Tag(
              title: 'Etiqueta',
              color: DEFAULT_TASK_COLOR,
              fecha: DateTime.now())),
    );
    if (result != null) {
      setState(() {
        tags.add(Tag(
          title: result['title'] as String,
          color: result['color'] as Color? ?? Colors.transparent,
          fecha: result['date'] as DateTime,
        ));
      });
    }
  }

  void _deleteTag(int index) {
    setState(() {
      tags.removeAt(index);
    });
  }
}
