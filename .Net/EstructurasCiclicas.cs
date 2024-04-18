public class EstructurasCiclicas
{
    public static void Main()
    {
        int numero = 0, valoresNegativos=0, valoresPositivos=0;
        int valorMinimo = int.MaxValue;
        int valorMaximo = int.MinValue;

        while (numero !=-99) {
            Console.WriteLine("Digite un numero entero");
            numero=Convert.ToInt16(Console.ReadLine());

            if (numero<0)
            {
                valoresNegativos++;
            }
            else
            {
                valoresPositivos++;
            }

            /*Valores minimo y maximo*/

            if (numero < valorMinimo)
            {
                valorMinimo = numero;
            }
            if (numero > valorMaximo)
            {
                valorMaximo = numero;
            }


        }

        Console.WriteLine("La cantidad de valores negativos es de "+valoresNegativos);
        Console.WriteLine("La cantidad de valores positivos es de " + valoresPositivos);
        Console.WriteLine("El valor mínimo ingresado es: " + (valorMinimo == int.MaxValue ? "No se ingresaron valores positivos." : valorMinimo.ToString()));
        Console.WriteLine("El valor máximo ingresado es: " + (valorMaximo == int.MinValue ? "No se ingresaron valores negativos." : valorMaximo.ToString()));


    }
}
