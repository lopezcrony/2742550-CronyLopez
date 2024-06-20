import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pago.dart';

class PagoService {
  static const String apiUrl = 'http://santiagoflorezzz-001-site1.ktempurl.com/api/Pagos';

  Future<List<Pago>> fetchPagos() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((pago) => Pago.fromJson(pago)).toList();
    } else {
      throw Exception('Failed to load pagos');
    }
  }

  Future<void> savePago(Pago pago) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pago.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to save pago');
    }
  }

  Future<void> updatePago(Pago pago) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${pago.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(pago.toJson()),
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to update pago');
    }
  }

  Future<void> deletePago(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete pago');
    }
  }
}