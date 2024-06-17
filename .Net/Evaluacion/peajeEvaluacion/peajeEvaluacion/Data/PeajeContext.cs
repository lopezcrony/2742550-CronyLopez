namespace peajeEvaluacion.Data
{
    public class PeajeContext : DbContext
    {
        public PeajeContext(DbContextOptions<PeajeContext> options):base(options)
        {
        }

        public DbSet<Peaje> Peajes { get; set; }
    }
}
