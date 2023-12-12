import 'package:finance_project/tasks_page.dart';
import 'package:finance_project/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'color_picker_dialog.dart';

class AddTagDialog extends StatefulWidget {
  final Tag initialTask;
  AddTagDialog({required this.initialTask});

  @override
  _AddTagDialogState createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  late TextEditingController controller;
  Color cardColor;
  DateTime selectedDate = DateTime.now();

  _AddTagDialogState() : cardColor = DEFAULT_TASK_COLOR;

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
            child: Text('Agregar Etiqueta'),
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
