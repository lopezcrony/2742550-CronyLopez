import 'package:flutter/material.dart';
import 'package:peajeapiexamen/screens/geolocalizador.dart';
import '../models/pago.dart';
import '../services/pagoservices.dart';
import 'formulario.dart';
import 'foto.dart'; // Importa la pantalla de tomar fotos
import 'pago.dart'; 

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Pagos de Peaje'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú de Navegación',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Gestión de Pagos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagoScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Tomar Foto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TakePhotoScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Geolocalización'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeolocatorScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Bienvenido a la Gestión de Pagos de Peaje'),
      ),
    );
  }
}
