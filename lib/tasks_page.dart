import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

const DEFAULT_TASK_COLOR = Colors.yellow;

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  // Aquí puedes definir la lista de tareas
  List<Task> tasks = List.generate(
    4,
    (index) => Task(title: 'Task $index', color: DEFAULT_TASK_COLOR,fecha: DateTime.now()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
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
}

class Task {
  final String title;
  final Color color;
  final DateTime fecha;
  Task({required this.title, required this.color, required this.fecha});
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  TaskCard({required this.task, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: task.color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            title: Text(task .title),
            trailing: Text(task.fecha.toString()),
            onTap: onTap,
          ),                
        ),
      ),
    );
  }
}

class EditTaskDialog extends StatefulWidget {
  final Task initialTask;

  EditTaskDialog({required this.initialTask});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController controller;
  Color cardColor;
  DateTime selectedDate = DateTime.now();

  _EditTaskDialogState() : cardColor = DEFAULT_TASK_COLOR;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialTask.title);
    cardColor = widget.initialTask.color;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text('Editar Tarea'),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _selectColor(context),
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text('Fecha: ${selectedDate.toLocal()}'.split(' ')[0]),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Guardar'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            onSurface: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop({
              'title': controller.text,
              'color': cardColor,
              'date': selectedDate,
            });
          },
        ),
      ],
    );
  }

  Future<void> _selectColor(BuildContext context) async {
    final color = await showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(initialColor: cardColor),
    );
    if (color != null) {
      setState(() {
        cardColor = color;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color initialColor;

  ColorPickerDialog({required this.initialColor});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    pickerColor = widget.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecciona un color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: (Color color) {
            setState(() {
              pickerColor = color;
            });
          },
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            Navigator.of(context).pop(pickerColor);
          },
        ),
      ],
    );
  }
}