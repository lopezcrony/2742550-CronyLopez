namespace peajeEvaluacion.Models
{
    public class Peaje
    {
        [Key]
        public int Id { get; set; }

        public string? Placa { get; set; }

        [Required]

        public string? NombrePeaje { get; set; }

        [Required]

        public string? IdCategoriaTarifa { get; set; }
        [Required]

        public DateTime FechaRegistro { get; set; }
        [Required]

        public decimal Valor { get; set; }
    }
}
