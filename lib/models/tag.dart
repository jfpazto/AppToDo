import 'package:flutter/material.dart';

class TagDto extends ChangeNotifier {
  final List<TagDto> tags = [];
  String title;
  Color color;
  DateTime fecha;

  TagDto({String? title, Color? color, DateTime? fecha})
      : this.title = title ?? '',
        this.color = color ?? Colors.white,
        this.fecha = fecha ?? DateTime.now();

  void updateColor(Color newColor) {
    color = newColor;
    notifyListeners(); // Notifica a los widgets que están escuchando este Tag
  }

  void addTag(TagDto tag) {
    tags.add(tag);
    notifyListeners();
  }
  void updateTag(int index, String newTitle, Color newColor) {
    if (index >= 0 && index < tags.length ) {
      tags[index].title = newTitle;
      tags[index].color = newColor;
      notifyListeners();
    } else {
      throw RangeError('index out of range');
    }
  }
  void deleteTag(int index) {
    if (index >= 0 && index < tags.length ) {
      tags.removeAt(index);
      notifyListeners();
    } else {
      throw RangeError('index out of range');
    }
  }
  List<TagDto> get allTags => tags;
}