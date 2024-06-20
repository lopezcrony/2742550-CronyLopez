import 'package:flutter/material.dart';
import '../models/pago.dart';
import '../services/pagoservices.dart';
import 'formulario.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  late PagoService _pagoService;
  late Future<List<Pago>> _futurePagos;

  @override
  void initState() {
    super.initState();
    _pagoService = PagoService();
    _futurePagos = _pagoService.fetchPagos();
  }

  void _refreshPagos() {
    setState(() {
      _futurePagos = _pagoService.fetchPagos();
    });
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey[700]!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Pagos de Peaje'),
      ),
      body: FutureBuilder<List<Pago>>(
        future: _futurePagos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay pagos registrados.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pago = snapshot.data![index];
                return ListTile(
                  title: Text('Placa: ${pago.placa}'),
                  subtitle: Text('${pago.nombrePeaje} - ${pago.idCategoriaTarifa} - ${pago.valor}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.amber,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PagoForm(
                                pago: pago,
                                onSave: _refreshPagos,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () async {
                          bool confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Confirmar eliminación'),
                              content: Text('¿Estás seguro de que deseas eliminar este pago?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text('Eliminar'),
                                ),
                              ],
                            ),
                          );
                          if (confirm) {
                            await _pagoService.deletePago(pago.id!);
                            _refreshPagos();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PagoForm(
                onSave: _refreshPagos,
              ),
            ),
          );
        },
      ),
    );
  }
}
