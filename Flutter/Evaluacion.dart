import 'dart:io';
// import 'dart:js_interop';

void main() {
  Banco banco = Banco();

  bool salir = false;

  do {
    print("1. Registrar cuenta");
    print("2. Realizar consignación");
    print("3. Realizar retiro");
    print("4. Realizar transferencia");
    print("5. Consultar saldo");
    print("6. Salir");
    print("Seleccione una opción: ");

    String? opcion = stdin.readLineSync();

    switch (opcion) {
      case "1":
        banco.registrarCuenta();
        break;
      case "2":
        banco.realizarConsignacion();
        break;
      case "3":
        banco.realizarRetiro();
        break;
      case "4":
        banco.realizarTransferencia();
        break;
      case "5":
        banco.consultarSaldo();
        break;
      case "6":
        salir = true;
        print("Saliendo...");
        break;
      default:
        print("Opción no válida. Inténtalo de nuevo.");
        break;
    }
  } while (!salir);
}

class Banco {
  List<CuentaBancaria> cuentas = [];

  void registrarCuenta() {
    print("Ingrese el número de la nueva cuenta:");
    int numeroCuenta = int.parse(stdin.readLineSync()!);

    if (cuentas.any((cuenta) => cuenta.numeroCuenta == numeroCuenta)) {
      print("Lo siento, la cuenta ya existe.");
    } else {
      cuentas.add(CuentaBancaria(numeroCuenta));
      print("Cuenta registrada exitosamente.");
    }
  }

  void realizarConsignacion() {
    print("Ingrese el número de cuenta:");
    int numeroCuenta = int.parse(stdin.readLineSync()!);

    var cuenta = getCuenta(numeroCuenta);

    if (cuenta != null) {
      print("Ingrese el valor a consignar:");
      double valor = double.parse(stdin.readLineSync()!);

      if (valor > 0) {
        cuenta.saldo += valor;
        print("Consignación realizada exitosamente.");
      } else {
        print("El valor a consignar debe ser mayor que 0.");
      }
    } else {
      print("La cuenta no existe.");
    }
  }

  void realizarRetiro() {
    print("Ingrese el número de cuenta:");
    int numeroCuenta = int.parse(stdin.readLineSync()!);

    var cuenta = getCuenta(numeroCuenta);

    if (cuenta != null) {
      print("Ingrese el valor a retirar:");
      double valor = double.parse(stdin.readLineSync()!);

      if (valor > 0 && valor <= cuenta.saldo) {
        cuenta.saldo -= valor;
        print("Retiro realizado exitosamente.");
      } else {
        print(
            "El valor a retirar debe ser mayor que 0 y menor o igual al saldo disponible.");
      }
    } else {
      print("La cuenta no existe.");
    }
  }

  void realizarTransferencia() {
    print("Ingrese el número de cuenta origen:");
    int numeroCuentaOrigen = int.parse(stdin.readLineSync()!);
    var cuentaOrigen = getCuenta(numeroCuentaOrigen);

    if (cuentaOrigen != null) {
      print("Ingrese el número de cuenta destino:");
      int numeroCuentaDestino = int.parse(stdin.readLineSync()!);
      var cuentaDestino = getCuenta(numeroCuentaDestino);

      if (cuentaDestino != null) {
        print("Ingrese el valor a transferir:");
        double valor = double.parse(stdin.readLineSync()!);

        if (valor > 0 && valor <= cuentaOrigen.saldo) {
          cuentaOrigen.saldo -= valor;
          cuentaDestino.saldo += valor;
          print("Transferencia realizada exitosamente.");
        } else {
          print(
              "El valor a transferir debe ser mayor que 0 y menor o igual al saldo disponible en la cuenta origen.");
        }
      } else {
        print("La cuenta destino no existe.");
      }
    } else {
      print("La cuenta origen no existe.");
    }
  }

  void consultarSaldo() {
    print("Ingrese el número de cuenta:");
    int numeroCuenta = int.parse(stdin.readLineSync()!);

    var cuenta = getCuenta(numeroCuenta);

    if (cuenta != null) {
      print("El saldo de la cuenta $numeroCuenta es: \$${cuenta.saldo}");
    } else {
      print("La cuenta no existe.");
    }
  }

  CuentaBancaria? getCuenta(int numeroCuenta) {
    return cuentas.firstWhere((cuenta) => cuenta.numeroCuenta == numeroCuenta);
  }
}

class CuentaBancaria {
  int numeroCuenta;
  double saldo = 0;

  CuentaBancaria(this.numeroCuenta) : saldo = 0;
}
