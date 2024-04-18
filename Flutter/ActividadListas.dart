// import 'dart:io';

import 'dart:io';

void main() {
  // print("Tipos de datos");

  // String empresa = "Sena";
  // int cantidadAprendices = 1200;
  // double temperaturaPromedio = 33.3;
  // bool estado = false;
  // final ambiente= 703; // Significa que el valor es inmutable//

  // print(
  //     "La empresa ${empresa} tiene ${cantidadAprendices} aprendices \nLa temperatura promedio es : ${temperaturaPromedio}");

  // if (estado) {
  //   print("Hay formación");
  // } else {
  //   print("No hay formación");
  // }
  // String? nombre = null; //El signo de interrogació es para indicar que el valor es nulo, de lo contraio genera error//

  // if (nombre == null) {
  //   print("Ingrese el nombre");
  // } else {
  //   print("Nombre ingresado");
  // }

  //CICLOS//

  // for (var i = 0; i < 100; i++) {
  //   print(i);
  // }

  // bool bandera = true;
  // while (bandera) {
  //   print("Acceder");
  // }

  // print("Write something");
  // String? a = stdin.readLineSync();
  // print("Esto fua ${a}");
  // int bandera = 1;
  // int cantidadNumeros;
  // int numerosNegativos = 0;
  // int numerosPositivos = 0;

  // print("Que cantidad de numeros desea ingresar? ");
  // cantidadNumeros = int.parse(stdin.readLineSync()!);

  // while (bandera <= cantidadNumeros) {
  //   print("Copie numeros");
  //   int numeros = int.parse(stdin.readLineSync()!);

  //   if (numeros >= 0) {
  //     numerosPositivos++;
  //   } else {
  //     numerosNegativos++;
  //   }

  //   bandera++;
  // }

  // print(numerosNegativos);
  // print(numerosPositivos);

  // stdout.write("holiwis: ");
  // String? value = stdin.readLineSync(encoding: utf8);
  // print(value);

  // --------------------------------------------------------  CLASE 2------------------------------------------
  // listas
  // un archivo plano es que solo hay datos

  // List<int> edades = [12, 13, 14, 15, 35];
  // print(edades);
  // edades.add(43);
  // print(edades);
  // print("Cantidad de elementos de la lista ${edades.length}");

  // int ContadorMayores = 0;
  // for (var i = 0; i < edades.length; i++) {
  //   if (edades[i] >= 18) {
  //     ContadorMayores++;
  //   }
  // }

  // print("los mayores de edadson: ${ContadorMayores}");
  // print("Edades sib ordenar ${edades}");
  // edades.sort(); //Ordenar los datos
  // print(edades.elementAt(1));
  // edades.removeAt(0); //Eliminar un elemento

  // print("Edades ordenadas: ${edades}");

  //Generar una lista con lo numeros del 1 al 100
  // final masNumeros = List.generate(101, (int index) => index);
  // print(masNumeros);

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
