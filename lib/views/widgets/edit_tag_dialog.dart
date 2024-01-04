import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:finance_project/models/tag.dart';
import 'color_picker_dialog.dart';

class EditTagDialog extends StatefulWidget {
  final int index;
  final String initialTitle;
  final Color initialColor;
  final Function(int, String, Color) updateTag;

  EditTagDialog({Key? key,required this.index,required this.initialTitle,required this.initialColor, required this.updateTag}) : super(key: key);

  @override
  _EditTagDialogState createState() => _EditTagDialogState();
}

class _EditTagDialogState extends State<EditTagDialog> {
  late Color cardColor;
  late TextEditingController _titleController;
  late TextEditingController _colorController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _colorController = TextEditingController(text: widget.initialColor.value.toRadixString(16));
    cardColor = widget.initialColor;
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
            child: Text('Editar Etiqueta'),
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
          ),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Actualizar'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blue,
            onSurface: Colors.grey,
          ),
          onPressed: () {
            widget.updateTag(widget.index, _titleController.text, cardColor);
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
}