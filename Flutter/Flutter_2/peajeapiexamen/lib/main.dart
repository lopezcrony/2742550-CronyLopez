import 'package:flutter/material.dart';
import 'package:peajeapiexamen/screens/foto.dart';
import 'package:peajeapiexamen/screens/inicio.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Pagos de Peaje',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Inicio(),
    );
  }
}

