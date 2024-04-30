using System;

class Program
{
    static void Main()
    {
        Credito credito = new Credito();

        bool salir = false;
        while (!salir)
        {
            Console.WriteLine("\nMenú:");
            Console.WriteLine("1. Registrar el valor total de compras.");
            Console.WriteLine("2. Realizar avances.");
            Console.WriteLine("3. Pagar Crédito.");
            Console.WriteLine("4. Consultar Cupo Crédito y Saldo por Pagar.");
            Console.WriteLine("5. Consultar Total Puntos.");
            Console.WriteLine("6. Salir");

            Console.Write("Ingrese su opción: ");
            int opcion = Convert.ToInt32(Console.ReadLine());

            switch (opcion)
            {
                case 1:
                    Console.Write("Ingrese el valor total de la compra: ");
                    double valorCompra = Convert.ToDouble(Console.ReadLine());
                    credito.RegistrarCompra(valorCompra);                    
                    break;

                case 2:
                    Console.Write("Ingrese el valor del avance: ");
                    double valorAvance = Convert.ToDouble(Console.ReadLine());
                    credito.RealizarAvance(valorAvance);                    
                    break;

                case 3:
                    Console.Write("Ingrese el valor del pago: ");
                    double valorPago = Convert.ToDouble(Console.ReadLine());
                    credito.PagarCredito(valorPago);                    
                    break;

                case 4:
                    Console.WriteLine($"Cupo Crédito disponible: {credito.ConsultarCupoDisponible()}");
                    Console.WriteLine($"Saldo por Pagar: {credito.ConsultarSaldoPorPagar()}");
                    break;

                case 5:
                    Console.WriteLine($"Total Puntos acumulados: {credito.ConsultarTotalPuntos()}");
                    break;

                case 6:
                    salir = true;
                    break;

                default:
                    Console.WriteLine("La opción ingresada no es  válida.");
                    break;
            }
        }
    }
}


class Credito
{
    public const double CupoCredito = 1000000;
    public double saldoPorPagar;
    public double totalPuntos;

    public Credito()
    {
        saldoPorPagar = 0;
        totalPuntos = 0;
    }

    public double ConsultarCupoDisponible()
    {
        return CupoCredito - saldoPorPagar;
    }

    public double ConsultarSaldoPorPagar()
    {
        return saldoPorPagar;
    }

    public double ConsultarTotalPuntos()
    {
        return totalPuntos;
    }

    public void RegistrarCompra(double valorCompra)
    {
        if (valorCompra <= 0 || valorCompra > ConsultarCupoDisponible() || CupoCredito == saldoPorPagar)
        {
            Console.WriteLine("No es posible realizar la compra");

        }

        saldoPorPagar += valorCompra;
        if (valorCompra >= 100000)
        {
            totalPuntos += valorCompra * 0.01;
        }

        Console.WriteLine("Compra registrada correctamente.");



    }

    public void RealizarAvance(double valorAvance)
    {
        if (valorAvance <= 0 || valorAvance > ConsultarCupoDisponible())
        {
            Console.WriteLine("No se puede realizar el avance");
        }

        saldoPorPagar += valorAvance;
            Console.WriteLine("Avance exitoso");

    }

    public void PagarCredito(double valorPago)
    {
        if (valorPago <= 0 || valorPago > saldoPorPagar)
        {
            Console.WriteLine("No es posible realizar el pago");
        }
        else {
            saldoPorPagar -= valorPago;
            Console.WriteLine("Pago registrada correctamente.");
        }

    }
}

