class Pago {
  int? id;
  String placa;
  String nombrePeaje;
  String idCategoriaTarifa;
  DateTime fechaRegistro;
  double valor;

  Pago({
    this.id,
    required this.placa,
    required this.nombrePeaje,
    required this.idCategoriaTarifa,
    required this.fechaRegistro,
    required this.valor,
  });

  factory Pago.fromJson(Map<String, dynamic> json) {
    return Pago(
      id: json['id'],
      placa: json['placa'],
      nombrePeaje: json['nombrePeaje'],
      idCategoriaTarifa: json['idCategoriaTarifa'],
      fechaRegistro: DateTime.parse(json['fechaRegistro']),
      valor: json['valor'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'placa': placa,
      'nombrePeaje': nombrePeaje,
      'idCategoriaTarifa': idCategoriaTarifa,
      'fechaRegistro': fechaRegistro.toIso8601String(),
      'valor': valor,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}