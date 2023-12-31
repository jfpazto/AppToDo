import 'package:finance_project/models/tag.dart';
import 'package:finance_project/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    DevicePreview(
      enabled: false, //Cambiar a true para ver el preview o false para desactivar
      builder: (context) => ChangeNotifierProvider(
        create: (context) => TagDto(),
        child: MyApp(),
      ),
    ),
  );
  
}

class MyApp extends StatelessWidget {//Se usa el StatelessWidget porque no se va a cambiar el estado de la app
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Toda app tiene un MaterialAPP
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),      
      home: LoginPage(),
    );
  }
}
