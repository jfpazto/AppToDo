import 'package:flutter/material.dart';

class Tag {
  final String title;
  Color color;
  final DateTime fecha;
  Tag({required this.title, required this.color, required this.fecha});

  void updateColor(Color newColor) {
    this.color = newColor;
  }
}