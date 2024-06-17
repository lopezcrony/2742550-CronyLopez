    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using peajeEvaluacion.Data;
    using peajeEvaluacion.Models;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;

namespace peajeEvaluacion.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PeajesController : ControllerBase
    {
        private readonly PeajeContext _context;

        public PeajesController(PeajeContext context)
        {
            _context = context;
        }

        // GET: api/Peajes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Peaje>>> GetPeajes()
        {
            return await _context.Peajes.ToListAsync();
        }

        // GET: api/Peajes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Peaje>> GetPeaje(int id)
        {
            var peaje = await _context.Peajes.FindAsync(id);

            if (peaje == null)
            {
                return NotFound();
            }

            return peaje;
        }

        // POST: api/Peajes
        [HttpPost]
        public async Task<ActionResult<Peaje>> PostPeaje(Peaje peaje)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            _context.Peajes.Add(peaje);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetPeaje), new { id = peaje.Id }, peaje);
        }

        // PUT: api/Peajes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPeaje(int id, Peaje peaje)
        {
            if (id != peaje.Id)
            {
                return BadRequest();
            }

            _context.Entry(peaje).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PeajeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/Peajes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePeaje(int id)
        {
            var peaje = await _context.Peajes.FindAsync(id);
            if (peaje == null)
            {
                return NotFound();
            }

            _context.Peajes.Remove(peaje);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool PeajeExists(int id)
        {
            return _context.Peajes.Any(e => e.Id == id);
        }
    }

}