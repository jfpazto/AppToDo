import 'package:flutter/material.dart';

class Tag extends ChangeNotifier {
  String title;
  Color color;
  DateTime fecha;

  Tag({required this.title, required this.color, required this.fecha});

  void updateColor(Color newColor) {
    color = newColor;
    notifyListeners();  // Notifica a los widgets que están escuchando este Tag
  }
}