import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class TakePhotoScreen extends StatefulWidget {
  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  File? _image;

  Future<void> _takePhoto() async {
    if (kIsWeb) {
      // Show a message if running on the web
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La funcionalidad de la cámara no está disponible en el navegador web.')),
      );
      return;
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tomar Foto'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No hay imagen seleccionada.')
                : kIsWeb
                    ? Image.network(_image!.path)
                    : Image.file(_image!), // Uso correcto de Image.file
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: Text('Tomar Foto'),
            ),
          ],
        ),
      ),
    );
  }
}
