using System;
using System.Security.Cryptography.X509Certificates;


public class Funciones
{ 

    public static void Main()
    {

        Console.WriteLine("valor en pesos: "+valorConversion(10).ToString("0.0"));
        Console.WriteLine("Valor en dolares: "+conversionDolares(10000).ToString("0.0"));
        puntocritico(valorConversion(1));
        porcentajeVariacion(4000,3800);
        List<double> dolares = new List<double>() { 344, 556, 10,340,15 };
        double maxDolar = valorMaxDolar(dolares);
        Console.WriteLine("El valor máximo en la lista de dólares es: " + maxDolar);


    }

    public static double valorConversion(double cantidadPesos)
    {
        return cantidadPesos * 4200.78;
    }

    public static double conversionDolares(double cantidadDolares)
    {
        return cantidadDolares / 4200.78;
    }

    public static void puntocritico(double valorConvercion)
    {
        String mensaje = "Normalidad económica";
        if (valorConvercion > 5000)
        {
            mensaje = "Alerta económica";
        }

        Console.WriteLine(mensaje);
    }

    public static void porcentajeVariacion(double precioActual, double PrecioAnterior)
    {
        double diferencia = precioActual - PrecioAnterior;
        double porcentajeVariacion=(diferencia/PrecioAnterior)*100;

        Console.WriteLine("Hubo una variación del "+porcentajeVariacion.ToString("0.0")+ " con respecto al valor anterior");        

    }

    static double valorMaxDolar(List<double> dolares)
    {
        double max = double.MinValue;
        foreach (double dolar in dolares)
        {
            if (dolar > max)
            {
                max = dolar;
            }
        }
        return max;
    }


}

