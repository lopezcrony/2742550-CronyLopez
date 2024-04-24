import 'dart:io';

void main() {
  inventario producto = new inventario("Leche", 5, 3400, 4000);
  producto.menu();
}

class inventario {
//Definir atributos
  String? nombre;
  int stock = 5;
  double? PrecioCompra;
  double? precioVenta;

  //Método Constructor
  inventario(String this.nombre, int this.stock, double this.PrecioCompra,
      double this.precioVenta);

  //Método
  void menu() {
    bool bandera = true;

    do {
      print(
          "\t SISTEMA DE COMPRA \n1.Registrar Compra \n2.Registrar Venta \n3.Salir");
      int opcion = int.parse(stdin.readLineSync()!);

      switch (opcion) {
        case 1:
          Compra();
          print(toString());
          break;
        case 2:
          Venta();
          print(toString());
          break;
        case 3:
          bandera = false;
          break;
        default:
      }
    } while (bandera != false);
  }

  void Compra() {
    print("Ingrese la cantidad");
    int cantidad = int.parse(stdin.readLineSync()!);

    if (cantidad < 0) {
      print(
          "No es posible realizar la compra ya que el valor ingresado es menor a cero.");
    } else {
      stock += cantidad;
    }
  }

  void Venta() {
    print("Ingrese la cantidad");
    int cantidad = int.parse(stdin.readLineSync()!);    

    int resta=stock-cantidad;

    if (cantidad < 0 || cantidad > stock ) {
      print(
          "La venta no puede ser realizada.");          
    }else if (resta<= 5) {
      print("No es posible vender.");
    } else {
      stock -= cantidad;
    }
    
  }

  @override
  String toString() {
    return ("\n~Producto~ \t~Cantidad~ \t~Precio de Venta~ \n$nombre \t\t    $stock\t\t     $precioVenta \n\n");
  }
}
