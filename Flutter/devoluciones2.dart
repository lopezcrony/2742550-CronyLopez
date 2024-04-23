
import 'dart:io';

void main() {
  bool deseaContinuar = true;

  do {
    int? codigoProducto;
    String? nombreProducto;
    int cantidadProducto = 0;
    String? empresa;
    String? TipoDevolucion;

    print("\tRegistrar nueva devolución");
    print("\nIngrese el codigo del producto:");
    codigoProducto = int.parse(stdin.readLineSync()!);

    print("\nIngrese el nombre del producto:");
    nombreProducto = stdin.readLineSync()!;

    print("\nIngrese la cantidad:");
    cantidadProducto = int.parse(stdin.readLineSync()!);

    print("\nIngrese el nombre de la empresa:");
    empresa = stdin.readLineSync()!;

    print("\nIngrese el tipo de devolución:");
    TipoDevolucion = stdin.readLineSync()!;

    devolucionesCompras devolucion = devolucionesCompras(
      codigoProducto,
      nombreProducto,
      cantidadProducto,
      empresa,
      TipoDevolucion,
    );

    devolucion.Registrar();

    // Preguntar al usuario si desea continuar
    print("\n¿Desea ingresar otra devolución? (s/n)");
    String? respuesta = stdin.readLineSync();
    if (respuesta?.toLowerCase() != 's') {
      deseaContinuar = false;
    }
  } while (deseaContinuar);
}

class devolucionesCompras {
  static int _contadorDevoluciones = 0;

  int? numeroDevolucion;
  int? codigoProducto;
  String? nombreProducto;
  int cantidadProducto = 0;
  String? empresa;
  String? TipoDevolucion;
  String fecha = "23/04/2024";

  devolucionesCompras(
    this.codigoProducto,
    this.nombreProducto,
    this.cantidadProducto,
    this.empresa,
    this.TipoDevolucion,
  ) {
    _contadorDevoluciones++;
    numeroDevolucion = _contadorDevoluciones;
  }

  void Registrar() {
    print("Se ha registrado la devolución con éxito");
    print(toString());
  }

  @override
  String toString() {
    return "\n\t INFORMACIÓN DE LA DEVOLUCIÓN \nCódigo de Devolución: $numeroDevolucion \nCodigo de Producto: $codigoProducto \nProducto: $nombreProducto \nCantidad: $cantidadProducto \nNombre de empresa: $empresa \nTipo de Devolución: $TipoDevolucion \nFecha: $fecha";
  }
}

