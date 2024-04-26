using System;
using System.Collections.Generic;

class Program
{
    static List<Aprendiz> aprendices = new List<Aprendiz>();

    static void Main()
    {
        bool continuar = true;
        while (continuar)
        {
            Console.WriteLine("Menú:");
            Console.WriteLine("1. Registrar inasistencias");
            Console.WriteLine("2. Listar Todas Inasistencias");
            Console.WriteLine("3. Listar los aprendices con inasistencias superiores a 3");
            Console.WriteLine("4. Consultar el total de inasistencias por aprendiz");
            Console.WriteLine("5. Valor a Pagar");
            Console.WriteLine("6. Número de suerte");
            Console.WriteLine("7. Salir");

            Console.Write("Seleccione una opción: ");
            int opcion=int.Parse(Console.ReadLine()!);
            

            
                switch (opcion)
                {
                    case 1:
                        RegistrarInasistencias();
                        break;
                    case 2:
                        ListarTodasInasistencias();
                        break;
                    case 3:
                        ListarInasistenciasSuperiores3();
                        break;
                    case 4:
                        ConsultarTotalInasistencias();
                        break;
                    case 5:
                        CalcularValorAPagar();
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
        int inasistencias;
        if (int.TryParse(Console.ReadLine(), out inasistencias) && inasistencias >= 1 && inasistencias <= 100)
        {
            Aprendiz existente = aprendices.Find(aprendiz => aprendiz.Documento == documento);
            if (existente != null)
            {
                existente.Inasistencias += inasistencias;
            }
            else
            {
                aprendices.Add(new Aprendiz(documento, nombre, inasistencias));
            }
            Console.WriteLine("Inasistencias registradas exitosamente.");
        }
        else
        {
            Console.WriteLine("Cantidad de inasistencias no válida. Debe estar entre 1 y 100.");
        }
    }

    static void ListarTodasInasistencias()
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
        string documento = Console.ReadLine();

        Aprendiz aprendiz = aprendices.Find(a => a.Documento == documento);
        if (aprendiz != null)
        {
            Console.WriteLine($"Total de inasistencias para {aprendiz.Nombre}: {aprendiz.Inasistencias}");
        }
        else
        {
            Console.WriteLine("Documento no encontrado.");
        }
    }

    static void CalcularValorAPagar()
    {
        Console.Write("Ingrese el código del producto: ");
        string codigo = Console.ReadLine();

        Console.Write("Ingrese el nombre del producto: ");
        string nombre = Console.ReadLine();

        Console.Write("Ingrese el precio del producto: ");
        decimal precio;
        if (decimal.TryParse(Console.ReadLine(), out precio) && precio > 0)
        {
            Console.Write("Ingrese la cantidad del producto: ");
            int cantidad;
            if (int.TryParse(Console.ReadLine(), out cantidad) && cantidad > 0)
            {
                decimal valorBruto = precio * cantidad;
                decimal descuento = cantidad > 10 ? valorBruto * 0.1m : 0;
                decimal valorIVA = valorBruto * 0.19m;
                decimal valorTotal = valorBruto + valorIVA - descuento;

                Console.WriteLine($"Valor a pagar: {valorTotal}");
            }
            else
            {
                Console.WriteLine("Cantidad no válida. Debe ser mayor que cero.");
            }
        }
        else
        {
            Console.WriteLine("Precio no válido. Debe ser mayor que cero.");
        }
    }

    static void GenerarNumeroSuerte()
    {
        Random rnd = new Random();
        int numero = rnd.Next(1000);
        Console.WriteLine($"Número de suerte: {numero:D3}");
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
