import 'dart:io';

void main() {
  // ------------- se agrega a una lista dependiedo si es hombre o mujer y luego se lista---------------------------

  List<String> Mujeres = [];
  List<String> Hombres = [];

  print("Cuantas personas desea ingresar: ");
  int cantidadDatos = int.parse(stdin.readLineSync()!);

  for (var i = 0; i < cantidadDatos; i++) {
    print("Ingrese H/M");
    String? genero = stdin.readLineSync()!.toLowerCase();

    print("Ingrese el nombre: ");
    String nombre = stdin.readLineSync()!;

    if (genero == "h") {
      Hombres.add(nombre);
    } else if (genero == "m") {
      Mujeres.add(nombre);
    }
  }

  print("Las mujeres agregadas fueron ${Mujeres}");
  print("Los hombres agregadas fueron ${Hombres}");
}
