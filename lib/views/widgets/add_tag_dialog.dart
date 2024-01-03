import 'package:finance_project/views/tasks_page.dart';
import 'package:finance_project/models/tag.dart';
import 'package:flutter/material.dart';
import 'color_picker_dialog.dart';
import 'package:provider/provider.dart';


class AddTagDialog extends StatefulWidget {
  final TagDto initialTask;
  final List<TagDto> tags;
  AddTagDialog({Key? key, required this.initialTask, required this.tags}) : super(key: key);

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
          GestureDetector(
            onTap: () => _selectColor(context),
            child: Container(
              width: 24,
              height: 24,
              margin: EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: cardColor,
                shape: BoxShape.circle,
              ),
            ),
          )
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
            TextFormField(
              controller: TextEditingController()..text = '${selectedDate.toLocal()}'.split(' ')[0],
              decoration: InputDecoration(
                labelText: 'Fecha',
                border: OutlineInputBorder(),
              ),
              onTap: () => _selectDate(context),
              readOnly: true,
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
            final newTag = TagDto(
              title: controller.text,
              color: cardColor,
              fecha: selectedDate,
            );
            Provider.of<TagDto>(context, listen: false).addTag(newTag);
            Navigator.of(context).pop();
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
