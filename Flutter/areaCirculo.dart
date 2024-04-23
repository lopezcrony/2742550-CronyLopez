import 'dart:math';

void main() {
  final circulo circulo1 = new circulo(3);
  circulo1.validar();
}

class circulo {
  double radio = 0;

  circulo(this.radio);

  void validar() {
    if (radio >= 0) {
      print("El area del círculo es de ${AreaCirculo().toStringAsFixed(2)}");
      print("El perimetro del círculo es de ${perimetro().toStringAsFixed(2)}");
    }
  }

  double AreaCirculo() {
    double area = pi * pow(radio, 2);
    return area;
  }

  double perimetro() {
    double perimetro = 2 * pi * radio;
    return perimetro;
  }
}
