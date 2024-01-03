// end_drawer.dart
import 'package:finance_project/models/tag.dart';
import 'package:flutter/material.dart';
import 'package:finance_project/views/widgets/add_tag_dialog.dart';
import 'package:provider/provider.dart';
import 'package:finance_project/views/widgets/triangle_tag.dart';

const DEFAULT_TASK_COLOR = Colors.yellow;

class TagsPage extends StatefulWidget {
  @override
  _TagsPageState createState() => _TagsPageState(); 
}

class _TagsPageState extends State<TagsPage> {
  late List<TagDto> tags;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tags = Provider.of<TagDto>(context, listen: false).allTags;
    Provider.of<TagDto>(context, listen: false).addTag(TagDto(title: 'Tag 2', color: Colors.blue, fecha: DateTime.now()));
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
          color: Color.fromARGB(255, 192, 192, 192),
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

  void editTag(BuildContext context, int index) {
    TextEditingController _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar etiquetas'),
          content: TextField(
            onChanged: (value) {
              Provider.of<TagDto>(context, listen: false).updateTag(index, value);
            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Etiqueta"),
          ),
          actions: <Widget>[
            // Tus acciones aquí
          ],
        );
      },
    );
  }

  void addTag(TagDto newTag) {
    setState(() {
      tags.add(newTag);
    });
  }

  @override
  Widget build(context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: _buildGradient(),
            ),
            child: Align(
              alignment: Alignment.center,
              child: _buildShaderMask('ETIQUETAS'),
            ),
          ),
          SizedBox(height: 0),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AddTagDialog(
                        initialTask: TagDto(title: "Nuevo título", color: Colors.red, fecha: DateTime.now()),
                        tags: tags,
                      );
                    },
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: Consumer<TagDto>(
              builder: (context, tagDto, child) {
                return ListView.builder(
                  itemCount: tagDto.allTags.length,
                  itemBuilder: (context, index) {
                    final tag = tagDto.allTags[index];
                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          color: tag.color,
                          child: ListTile(
                            leading: Container(
                              width: 10, // Ajusta este valor para cambiar el tamaño del círculo
                              height: 10, // Ajusta este valor para cambiar el tamaño del círculo
                              decoration: BoxDecoration(
                                color: Colors.white, // Cambia esto al color de tu página
                                shape: BoxShape.circle,
                              ),
                            ),
                            title: Text(tag.title,
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              editTag(context, index);
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: CustomPaint(
                            painter: Triangle(tag.color),
                            child: SizedBox(
                              width: 20,
                              height: double.infinity,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
