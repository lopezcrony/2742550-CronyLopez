import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorScreen extends StatefulWidget {
  @override
  _GeolocatorScreenState createState() => _GeolocatorScreenState();
}

class _GeolocatorScreenState extends State<GeolocatorScreen> {
  String _locationMessage = "";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Los servicios de ubicación no están habilitados
      setState(() {
        _locationMessage = "Los servicios de ubicación están deshabilitados.";
      });
      return;
    }

    // Verificar si se tienen permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Los permisos de ubicación están denegados
        setState(() {
          _locationMessage = "Los permisos de ubicación están denegados.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Los permisos están denegados permanentemente
      setState(() {
        _locationMessage = "Los permisos de ubicación están denegados permanentemente.";
      });
      return;
    }

    // Obtener la posición actual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _locationMessage = "Latitud: ${position.latitude}, Longitud: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geolocalizador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_locationMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: Text('Obtener Ubicación Actual'),
            ),
          ],
        ),
      ),
    );
  }
}