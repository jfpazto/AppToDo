import 'package:flutter/material.dart';

class DeleteTagDialog extends StatelessWidget {
  final int index;
  final Function(int) deleteTag;

  DeleteTagDialog({Key? key, required this.index, required this.deleteTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Eliminar etiqueta'),
      content: Text('¿Estás seguro de que quieres eliminar esta etiqueta?'),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Eliminar'),
          onPressed: () {
            deleteTag(index);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}