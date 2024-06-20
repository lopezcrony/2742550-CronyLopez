import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pago.dart';
import '../services/pagoservices.dart';

class PagoForm extends StatefulWidget {
  final Pago? pago;
  final Function onSave;

  PagoForm({this.pago, required this.onSave});

  @override
  _PagoFormState createState() => _PagoFormState();
}

class _PagoFormState extends State<PagoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Pago _editedPago;
  TextEditingController _fechaRegistroController = TextEditingController();
  List<String> _nombrePeajes = [];
  Map<String, Map<String, double>> _peajesValores = {};

  @override
  void initState() {
    super.initState();
    _editedPago = widget.pago != null
        ? Pago(
            id: widget.pago!.id,
            placa: widget.pago!.placa,
            nombrePeaje: widget.pago!.nombrePeaje,
            idCategoriaTarifa: widget.pago!.idCategoriaTarifa,
            fechaRegistro: widget.pago!.fechaRegistro,
            valor: widget.pago!.valor,
          )
        : Pago(
            placa: '',
            nombrePeaje: '',
            idCategoriaTarifa: 'I',
            fechaRegistro: DateTime.now(),
            valor: 0.0,
          );
    _fechaRegistroController.text =
        DateFormat('yyyy-MM-dd HH:mm').format(_editedPago.fechaRegistro);
    _fetchPeajes();
  }

void _saveForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    try {
      final url = _editedPago.id == null
          ? Uri.parse('http://santiagoflorezzz-001-site1.ktempurl.com/api/Pagos')
          : Uri.parse('http://santiagoflorezzz-001-site1.ktempurl.com/api/Pagos/${_editedPago.id}');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode(_editedPago.toJson());

      final response = _editedPago.id == null
          ? await http.post(url, headers: headers, body: body)
          : await http.put(url, headers: headers, body: body);

      if (response.statusCode == 201 || response.statusCode == 200 || response.statusCode == 204) {
        print('Pago guardado correctamente');
        widget.onSave();
        Navigator.pop(context);
      } else {
        print('Error al guardar pago: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to save pago');
      }
    } catch (e) {
      print('Error en la solicitud POST/PUT: $e');
    }
  }
}


  Future<void> _fetchPeajes() async {
    final url = Uri.parse('https://www.datos.gov.co/resource/7gj8-j6i3.json');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final Map<String, Map<String, double>> peajesValores = {};
        for (var item in data) {
          final peaje = item['peaje'];
          final categoria = item['idcategoriatarifa'];
          final valor = double.tryParse(item['valor'].toString()) ?? 0.0;
          if (!peajesValores.containsKey(peaje)) {
            peajesValores[peaje] = {};
          }
          peajesValores[peaje]![categoria] = valor;
        }
        setState(() {
          _nombrePeajes = peajesValores.keys.toList();
          _peajesValores = peajesValores;
          if (_nombrePeajes.isNotEmpty && _editedPago.nombrePeaje.isEmpty) {
            _editedPago.nombrePeaje = _nombrePeajes[0];
          }
          _autocompletarValor();
        });
      } else {
        throw Exception('Failed to load peajes');
      }
    } catch (e) {
      print('Error fetching peajes: $e');
    }
  }

  void _autocompletarValor() {
    if (_editedPago.nombrePeaje.isNotEmpty &&
        _editedPago.idCategoriaTarifa.isNotEmpty) {
      setState(() {
        _editedPago.valor = _peajesValores[_editedPago.nombrePeaje]
                ?[_editedPago.idCategoriaTarifa] ??
            0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pago != null ? 'Editar Pago' : 'Nuevo Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _editedPago.placa,
                decoration: InputDecoration(labelText: 'Placa'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (!RegExp(r'^[A-Z0-9]+$').hasMatch(value)) {
                    return 'Formato de placa incorrecto';
                  }
                  return null;
                },
                onSaved: (value) => _editedPago.placa = value!,
              ),
              SizedBox(height: 10),
              if (_nombrePeajes.isEmpty)
                Center(child: CircularProgressIndicator())
              else
                DropdownButtonFormField<String>(
                  value: _nombrePeajes.contains(_editedPago.nombrePeaje)
                      ? _editedPago.nombrePeaje
                      : null,
                  decoration: InputDecoration(labelText: 'Nombre del Peaje'),
                  items: _nombrePeajes.map((peaje) {
                    return DropdownMenuItem(
                      value: peaje,
                      child: Text(peaje),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _editedPago.nombrePeaje = value!;
                      _autocompletarValor();
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: ['I', 'II', 'III', 'IV', 'V']
                        .contains(_editedPago.idCategoriaTarifa)
                    ? _editedPago.idCategoriaTarifa
                    : null,
                decoration: InputDecoration(labelText: 'Categoría de Tarifa'),
                items: ['I', 'II', 'III', 'IV', 'V'].map((categoria) {
                  return DropdownMenuItem(
                    value: categoria,
                    child: Text(categoria),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _editedPago.idCategoriaTarifa = value!;
                    _autocompletarValor();
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(labelText: 'Valor'),
                controller:
                    TextEditingController(text: _editedPago.valor.toString()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Ingrese un número válido';
                  }
                  if (double.parse(value) < 0) {
                    return 'El valor debe ser mayor o igual a 0';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _fechaRegistroController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha de Registro',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _editedPago.fechaRegistro,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null &&
                          picked != _editedPago.fechaRegistro) {
                        setState(() {
                          _editedPago.fechaRegistro = picked;
                          _fechaRegistroController.text =
                              DateFormat('yyyy-MM-dd').format(picked);
                        });
                      }
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
