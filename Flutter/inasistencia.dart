import 'dart:io';
import 'dart:math';


class Aprendiz {
  String documento;
  String nombre;
  int inasistencias;

  Aprendiz(this.documento, this.nombre, this.inasistencias);
}

void main() {
  mostrarMenu();
}

void mostrarMenu() {
  var aprendices = <Aprendiz>[];
  var continuar = true;

  while (continuar) {
    print('Menú:');
    print('1. Registrar inasistencias');
    print('2. Listar todas las inasistencias');
    print('3. Listar los aprendices con inasistencias superiores a 3');
    print('4. Consultar el total de inasistencias por aprendiz');
    print('5. Valor a Pagar');
    print('6. Número de suerte');
    print('7. Salir');
    stdout.write('Seleccione una opción: ');
    int opcion = int.parse(stdin.readLineSync()!);

    switch (opcion) {
      case 1:
        registrarInasistencias(aprendices);
        break;
      case 2:
        listarInasistencias(aprendices);
        break;
      case 3:
        listarInasistenciasSuperiores3(aprendices);
        break;
      case 4:
        consultarTotalInasistencias(aprendices);
        break;
      case 5:
        pago pago1 = new pago();
        pago1.calcularValorAPagar();
        break;
      case 6:
        generarNumeroSuerte();
        break;
      case 7:
        continuar = false;
        print('Saliendo...');
        break;
      default:
        print('Opción no válida. Por favor, seleccione una opción válida.');
        break;
    }

    print('');
  }
}

void registrarInasistencias(List<Aprendiz> aprendices) {
  stdout.write('Ingrese el documento del aprendiz: ');
  String documento = stdin.readLineSync()!;
  stdout.write('Ingrese el nombre completo del aprendiz: ');
  String nombre = stdin.readLineSync()!;
  stdout.write('Ingrese la cantidad de inasistencias (entre 1 y 100): ');
  int inasistencias = int.parse(stdin.readLineSync()!);

  if (inasistencias < 1 || inasistencias > 100) {
    print('Cantidad de inasistencias no válida. Debe estar entre 1 y 100.');
    return;
  }

  var existenteIndex =
      aprendices.indexWhere((aprendiz) => aprendiz.documento == documento);
  if (existenteIndex != -1) {
    aprendices[existenteIndex].inasistencias += inasistencias;
    print('Inasistencias actualizadas exitosamente para el aprendiz.');
  } else {
    aprendices.add(Aprendiz(documento, nombre, inasistencias));
    print('Inasistencias registradas exitosamente para el nuevo aprendiz.');
  }
}

void listarInasistencias(List<Aprendiz> aprendices) {
  if (aprendices.isEmpty) {
    print('No hay aprendices registrados.');
  } else {
    print('Inasistencias de todos los aprendices:');
    aprendices.forEach((aprendiz) {
      print(
          'Documento: ${aprendiz.documento}, Nombre: ${aprendiz.nombre}, Inasistencias: ${aprendiz.inasistencias}');
    });
  }
}

void listarInasistenciasSuperiores3(List<Aprendiz> aprendices) {
  if (aprendices.isEmpty) {
    print('No hay aprendices registrados.');
  } else {
    print('Aprendices con inasistencias superiores a 3:');
    var hayAprendices = false;
    aprendices.forEach((aprendiz) {
      if (aprendiz.inasistencias > 3) {
        print(
            'Documento: ${aprendiz.documento}, Nombre: ${aprendiz.nombre}, Inasistencias: ${aprendiz.inasistencias}');
        hayAprendices = true;
      }
    });
    if (!hayAprendices) {
      print('No hay aprendices con inasistencias superiores a 3.');
    }
  }

  
}

void consultarTotalInasistencias(List<Aprendiz> aprendices) {
  stdout.write('Ingrese el documento del aprendiz: ');
  String? documento = stdin.readLineSync();
  var aprendiz = aprendices.firstWhere(
      (aprendiz) => aprendiz.documento == documento,
      orElse: () => Aprendiz('', '', 0));

  if (aprendiz.documento.isNotEmpty) {
    print('Total de inasistencias para ${aprendiz.nombre}: ${aprendiz.inasistencias}');
  } else {
    print('Documento no encontrado.');
  }
  
}

void generarNumeroSuerte() {
  var rnd = Random();
  var numero = rnd.nextInt(1000);
  print('Número de suerte: ${numero.toString().padLeft(3, '0')}');
}

class pago {
  int? codigo;
  String? nombre;
  double? precio;
  int? cantidad;

  void calcularValorAPagar() {
    stdout.write('Ingrese el código del producto: ');
    int codigo = int.parse(stdin.readLineSync()!);
    stdout.write('Ingrese el nombre del producto: ');
    String? nombre = stdin.readLineSync();
    stdout.write('Ingrese el precio del producto: ');
    double precio = double.parse(stdin.readLineSync()!);

    if (precio <= 0) {
      print('Precio no válido. Debe ser mayor que cero.');
      return;
    }

    stdout.write('Ingrese la cantidad del producto: ');
    var cantidad = int.parse(stdin.readLineSync()!);

    if (cantidad <= 0) {
      print('Cantidad no válida. Debe ser mayor que cero.');
      return;
    }

    var valorBruto = precio * cantidad;
    var descuento = cantidad > 10 ? valorBruto * 0.1 : 0;
    var valorIVA = valorBruto * 0.19;
    var valorTotal = valorBruto + valorIVA - descuento;

    print('Código:$codigo \nProducto:$nombre \nValor a pagar: $valorTotal');
  }
}
