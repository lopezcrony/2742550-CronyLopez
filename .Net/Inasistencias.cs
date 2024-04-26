using System;
using System.Collections.Generic;
using static System.Runtime.InteropServices.JavaScript.JSType;

class Program
{
    static List<Aprendiz> aprendices = new List<Aprendiz>();

    static void Main()
    {
        MostrarMenu();  
        
    }

    static void MostrarMenu()
    {
        


        bool continuar = true;
        while (continuar)
        {
            Console.WriteLine("Menú:");
            Console.WriteLine("1. Registrar inasistencias");
            Console.WriteLine("2. Listar todas las inasistencias");
            Console.WriteLine("3. Listar los aprendices con inasistencias superiores a 3");
            Console.WriteLine("4. Consultar el total de inasistencias por aprendiz");
            Console.WriteLine("5. Valor a Pagar");
            Console.WriteLine("6. Número de suerte");
            Console.WriteLine("7. Salir");
            Console.Write("Seleccione una opción: ");

            int opcion = int.Parse(Console.ReadLine()!);

            switch (opcion)
            {
                case 1:
                    RegistrarInasistencias();
                    break;
                case 2:
                    ListarInasistencias();
                    break;
                case 3:
                    ListarInasistenciasSuperiores3();
                    break;
                case 4:
                    ConsultarTotalInasistencias();
                    break;
                case 5:
                    Pago pago1 = new Pago();
                    pago1.CalcularValorAPagar();
                    break;
                case 6:
                    GenerarNumeroSuerte();
                    break;
                case 7:
                    continuar = false;
                    Console.WriteLine("Saliendo...");
                    break;
                default:
                    Console.WriteLine("Opción no válida. Por favor, seleccione una opción válida.");
                    break;
            }


            Console.WriteLine();
        }
    }

    static void RegistrarInasistencias()
    {
        Console.Write("Ingrese el documento del aprendiz: ");
        string documento = Console.ReadLine()!;

        Console.Write("Ingrese el nombre completo del aprendiz: ");
        string nombre = Console.ReadLine()!;

        Console.Write("Ingrese la cantidad de inasistencias (entre 1 y 100): ");
        int inasistencias = int.Parse(Console.ReadLine()!);

        if (inasistencias < 1 || inasistencias > 100)
        {
            Console.WriteLine("Cantidad de inasistencias no válida. Debe estar entre 1 y 100.");
            return;
        }

        Aprendiz aprendiz = aprendices.Find(z => z.Documento == documento);
        if (aprendiz != null)
        {
            aprendiz.Inasistencias += inasistencias;
        }
        else
        {
            aprendices.Add(new Aprendiz(documento, nombre, inasistencias));
        }
        Console.WriteLine("Inasistencias registradas exitosamente.");
    }

    static void ListarInasistencias()
    {
        Console.WriteLine("Inasistencias de todos los aprendices:");
        foreach (var aprendiz in aprendices)
        {
            Console.WriteLine($"Documento: {aprendiz.Documento}, Nombre: {aprendiz.Nombre}, Inasistencias: {aprendiz.Inasistencias}");
        }
    }

    static void ListarInasistenciasSuperiores3()
    {
        Console.WriteLine("Aprendices con inasistencias superiores a 3:");
        foreach (var aprendiz in aprendices)
        {
            if (aprendiz.Inasistencias > 3)
            {
                Console.WriteLine($"Documento: {aprendiz.Documento}, Nombre: {aprendiz.Nombre}, Inasistencias: {aprendiz.Inasistencias}");
            }
        }
    }

    static void ConsultarTotalInasistencias()
    {
        Console.Write("Ingrese el documento del aprendiz: ");
        string documento = Console.ReadLine()!;

        Aprendiz aprendiz = aprendices.Find(z => z.Documento == documento);
        if (aprendiz != null)
        {
            Console.WriteLine($"Total de inasistencias para {aprendiz.Nombre}: {aprendiz.Inasistencias}");
        }
        else
        {
            Console.WriteLine("Documento no encontrado.");
        }
    }

    static void GenerarNumeroSuerte()
    {
        Random rnd = new Random();
        int numero = rnd.Next(1000);
        Console.WriteLine($"Número de suerte: {numero:D3}");
    }
}


class Pago
{
    public int Codigo { get; set; }
    public required string Nombre { get; set; }
    public double Precio { get; set; }
    public int Cantidad { get; set; }

    public void CalcularValorAPagar()
    {
        Console.Write("Ingrese el código del producto: ");
        int Codigo = int.Parse(Console.ReadLine()!);
        Console.Write("Ingrese el nombre del producto: ");
        System.String Nombre = Console.ReadLine()!;
        Console.Write("Ingrese el precio del producto: ");
        double Precio = double.Parse(Console.ReadLine()!);

        if (Precio <= 0)
        {
            Console.WriteLine("Precio no válido. Debe ser mayor que cero.");
            return;
        }

        Console.Write("Ingrese la cantidad del producto: ");
        int Cantidad = int.Parse(Console.ReadLine()!);

        if (Cantidad <= 0)
        {
            Console.WriteLine("Cantidad no válida. Debe ser mayor que cero.");
            return;
        }

        double valorBruto = Precio * Cantidad;
        double descuento = Cantidad > 10 ? valorBruto * 0.1 : 0;
        double valorIVA = valorBruto * 0.19;
        double valorTotal = valorBruto + valorIVA - descuento;

        Console.WriteLine($"Código: {Codigo}\nProducto: {Nombre}\nValor a pagar: {valorTotal}");
    }
}


class Aprendiz
{
    public string Documento { get; set; }
    public string Nombre { get; set; }
    public int Inasistencias { get; set; }

    public Aprendiz(string documento, string nombre, int inasistencias)
    {
        Documento = documento;
        Nombre = nombre;
        Inasistencias = inasistencias;
    }
}
