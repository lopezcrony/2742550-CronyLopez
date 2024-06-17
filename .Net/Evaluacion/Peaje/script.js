document.addEventListener('DOMContentLoaded', () => {
    const apiBaseUrl = 'http://localhost:5135/api/Peajes';
    const externalApiUrl = 'https://www.datos.gov.co/resource/7gj8-j6i3.json';

    const peajeForm = document.getElementById('peajeForm');
    const peajeTableBody = document.querySelector('#peajeTable');
    
    const nombrePeajeSelect = document.getElementById('nombrePeaje');
    const idCategoriaTarifaSelect = document.getElementById('idCategoriaTarifa');
    const valorInput = document.getElementById('valor');

        // Cargar nombres de peajes desde la API externa
    fetch(externalApiUrl)
        .then(response => response.json())
        .then(data => {
            console.log('API externa datos:', data); // Añade este log para verificar la respuesta
            data.forEach(peaje => {
                const option = document.createElement('option');
                option.value = peaje.peaje; // Ajusta esto si el nombre del campo es diferente
                option.text = peaje.peaje; // Ajusta esto si el nombre del campo es diferente
                nombrePeajeSelect.add(option);
            });
        })
        .catch(error => console.error('Error al cargar nombres de peajes:', error));

    // Autocompletar valor del peaje
    function autocompletarValor() {
        const nombrePeaje = nombrePeajeSelect.value;
        const idCategoriaTarifa = idCategoriaTarifaSelect.value;

        fetch(externalApiUrl)
            .then(response => response.json())
            .then(data => {
                const peaje = data.find(p => p.peaje == nombrePeaje && p.idcategoriatarifa == idCategoriaTarifa);
                if (peaje) {
                    valorInput.value = peaje.valor; // Ajusta esto si el nombre del campo es diferente
                } else {
                    valorInput.value = '';
                }
            })
            .catch(error => console.error('Error al autocompletar valor del peaje:', error));
    }

    nombrePeajeSelect.addEventListener('change', autocompletarValor);
    idCategoriaTarifaSelect.addEventListener('change', autocompletarValor);

    function autocompletarValor2() {
        const editNombrePeajeSelect = document.getElementById('editnombrePeaje');
        const editIdCategoriaTarifaSelect = document.getElementById('editidCategoriaTarifa');
        const editValorInput = document.getElementById('editvalor');

        const editnombrePeaje = editNombrePeajeSelect.value;
        const editidCategoriaTarifa = editIdCategoriaTarifaSelect.value;

        fetch(externalApiUrl)
            .then(response => response.json())
            .then(data => {
                const peaje = data.find(p => p.peaje == editnombrePeaje && p.idcategoriatarifa == editidCategoriaTarifa);
                if (peaje) {
                    editValorInput.value = peaje.valor; // Ajusta esto si el nombre del campo es diferente
                } else {
                    editValorInput.value = '';
                }
            })
            .catch(error => console.error('Error al autocompletar valor del peaje:', error));
    }

    // Event listeners para autocompletar valor en el formulario de edición
    document.getElementById('editnombrePeaje').addEventListener('change', autocompletarValor2);
    document.getElementById('editidCategoriaTarifa').addEventListener('change', autocompletarValor2);

    // Cargar todos los peajes
    function cargarPeajes() {
        fetch(apiBaseUrl)
            .then(response => response.json())
            .then(peajes => {
                peajeTableBody.innerHTML = '';
                peajes.forEach(peaje => {
                    const row = document.createElement('tr');

                    row.innerHTML = `
                        <td>${peaje.placa}</td>
                        <td>${peaje.nombrePeaje}</td>
                        <td>${peaje.idCategoriaTarifa}</td>
                        <td>${Date(peaje.fechaRegistro).toLocaleString()}</td>
                        <td>${peaje.valor}</td>
                        <td>
                            <button class="btn btn-outline-warning edit" data-toggle="modal" data-target="#editpeajeModal" data-id="${peaje.id}">Edit</button>
                            <button class="btn btn-outline-danger delete" data-id="${peaje.id}">X</button>
                        </td>
                    `;

                    peajeTableBody.appendChild(row);
                });

                document.querySelectorAll('.edit').forEach(button => {
                    button.addEventListener('click', editarPeaje);
                });

                document.querySelectorAll('.delete').forEach(button => {
                    button.addEventListener('click', eliminarPeaje);
                });
            })
            .catch(error => console.error('Error al cargar peajes:', error));
    }

    // Registrar un nuevo peaje
    peajeForm.addEventListener('submit', (event) => {
        event.preventDefault();

        const formData = new FormData(peajeForm);
        const peaje = {
            placa: formData.get('placa'),
            nombrePeaje: formData.get('nombrePeaje'),
            idCategoriaTarifa: formData.get('idCategoriaTarifa'),
            fechaRegistro: new Date().toISOString(),
            valor: parseFloat(formData.get('valor'))
        };

        fetch(apiBaseUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(peaje)
        })
        .then(response => response.json())
        .then(() => {
            peajeForm.reset();
            cargarPeajes();
            location.reload()
        })
        .catch(error => console.error('Error al registrar peaje:', error));
    });

    
    // Editar peaje
    function editarPeaje(event) {
        const id = event.target.getAttribute('data-id');

        fetch(`${apiBaseUrl}/${id}`)
            .then(response => response.json())
            .then(peaje => {
                document.getElementById('editplaca').value = peaje.placa;
                document.getElementById('editId').value = peaje.id;
                
                // Configurar nombre del peaje
                fetch(externalApiUrl)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('editnombrePeaje').innerHTML = '';
                        data.forEach(peajeOption => {
                            const option = document.createElement('option');
                            option.value = peajeOption.peaje; // Ajustar si el nombre del campo es diferente
                            option.text = peajeOption.peaje; // Ajustar si el nombre del campo es diferente
                            document.getElementById('editnombrePeaje').appendChild(option);
                        });

                        // Seleccionar el valor del peaje correspondiente
                        document.getElementById('editnombrePeaje').value = peaje.nombrePeaje;
                        autocompletarValor2(); // Autocompletar el valor al cargar el peaje
                    })
                    .catch(error => console.error('Error al cargar nombres de peajes para editar:', error));

                document.getElementById('editidCategoriaTarifa').value = peaje.idCategoriaTarifa;
                document.getElementById('editvalor').value = peaje.valor;

                // Remover el listener anterior y añadir uno nuevo para actualizar
                
            })
            .catch(error => console.error('Error al editar peaje:', error));
    }

    

    // Función para actualizar un peaje
   

    function registrarPeaje(event) {
        event.preventDefault();
        // código para registrar peaje
    }
    

    // Eliminar peaje
    function eliminarPeaje(event) {
        const id = event.target.getAttribute('data-id');

        fetch(`${apiBaseUrl}/${id}`, {
            method: 'DELETE'
        })
        .then(() => {
            cargarPeajes();
        })
        .catch(error => console.error('Error al eliminar peaje:', error));
    }

    cargarPeajes();
});

function actualizarPeaje() {
    
    // fetch(externalApiUrl)
    // .then(response => response.json())
    // id=response.idpeaje
    const modalEdit = document.getElementById('editpeajeModal');
    const Id=document.getElementById('editId').value
    const placa=document.getElementById('editplaca').value
    const nombrePeaje=document.getElementById('editnombrePeaje').value
    const idCategoriaTarifa=document.getElementById('editidCategoriaTarifa').value
    const valor=document.getElementById('editvalor').value
    const fecha= Date.toString

    const peaje = {
        Id,
        placa,
        nombrePeaje,
        idCategoriaTarifa,
        fecha,
        valor
    };
    console.log(peaje)

    fetch(`http://localhost:5135/api/Peajes/${Id}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(peaje)
    })
    .then(() => {
        console.log("actualizado con exito");
        modalEdit.hidden
        location.reload()
    })
    .catch(error => console.error('Error al actualizar peaje:', error));
}