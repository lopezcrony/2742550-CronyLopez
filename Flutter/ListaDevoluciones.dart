import 'dart:io';

void main() {
  List<String> devoluciones = [];

  bool salir = false;

  while (!salir) {
    print("1. Insertar devolución");
    print("2. Modificar devolución");
    print("3. Eliminar devolución");
    print("4. Consultar devoluciones");
    print("5. Salir");
    stdout.write("Seleccione una opción: ");

    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case "1":
        insertarDevolucion(devoluciones);
        break;
      case "2":
        modificarDevolucion(devoluciones);
        break;
      case "3":
        eliminarDevolucion(devoluciones);
        break;
      case "4":
        consultarDevoluciones(devoluciones);
        break;
      case "5":
        salir = true;
        break;
      default:
        print("Opción no válida. Inténtalo de nuevo.");
        break;
    }
  }
}

void insertarDevolucion(List<String> devoluciones) {
  stdout.write("Ingrese la devolución: ");
  String? devolucion = stdin.readLineSync();
  devoluciones.add(devolucion!);
  print("Devolución agregada exitosamente.");
}

void modificarDevolucion(List<String> devoluciones) {
  stdout.write("Ingrese el índice de la devolución que desea modificar: ");
  int? indice = int.parse(stdin.readLineSync()!);

  if (indice >= 0 && indice < devoluciones.length) {
    stdout.write("Ingrese la nueva devolución: ");
    String? nuevaDevolucion = stdin.readLineSync();
    devoluciones[indice] = nuevaDevolucion!;
    print("Devolución modificada exitosamente.");
  } else {
    print("Índice no válido.");
  }
}

void eliminarDevolucion(List<String> devoluciones) {
  stdout.write("Ingrese el índice de la devolución que desea eliminar: ");
  int? indice = int.parse(stdin.readLineSync()!);

  if (indice >= 0 && indice < devoluciones.length) {
    devoluciones.removeAt(indice);
    print("Devolución eliminada exitosamente.");
  } else {
    print("Índice no válido.");
  }
}

void consultarDevoluciones(List<String> devoluciones) {
  print("Devoluciones:");
  for (int i = 0; i < devoluciones.length; i++) {
    print("$i: ${devoluciones[i]}");
  }
}
