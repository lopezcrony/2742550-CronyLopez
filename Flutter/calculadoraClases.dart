import 'dart:io';

void main() {
  int bandera = 0;
  int opcion;

  while (bandera != 5) {
    print(
        "Ingrese la operación a realizar \n1.Sumar \n2.Restar \n3.Multiplicar \n4.Dividir \n5.Salir");
    opcion = int.parse(stdin.readLineSync()!);

    switch (opcion) {
      case 1:
        print(suma());
        break;
      case 2:
        print(resta());
        break;
      case 3:
        print(multiplicacion());
        break;
      case 4:
        print(dividir());
        break;
      case 5:
        bandera = 5;
        break;

      default:
        break;
    }

    
  }
}

double suma() {
   print("Ingrese el primer numero");
    double numero1 = double.parse(stdin.readLineSync()!);

    print("Ingrese el segundo numero");
   double  numero2 = double.parse(stdin.readLineSync()!);

  return numero1 + numero2;
}

double resta() {
  print("Ingrese el primer numero");
    double numero1 = double.parse(stdin.readLineSync()!);

    print("Ingrese el segundo numero");
   double  numero2 = double.parse(stdin.readLineSync()!);

  return numero1 - numero2;
}

double multiplicacion() {
  print("Ingrese el primer numero");
    double numero1 = double.parse(stdin.readLineSync()!);

    print("Ingrese el segundo numero");
   double  numero2 = double.parse(stdin.readLineSync()!);
  return numero1 * numero2;
}

double dividir() {
  print("Ingrese el primer numero");
    double numero1 = double.parse(stdin.readLineSync()!);

    print("Ingrese el segundo numero");
   double  numero2 = double.parse(stdin.readLineSync()!);

  return numero1 / numero2;
}
