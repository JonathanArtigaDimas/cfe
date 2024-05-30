const fondo_jardin = document.querySelector("#fondo-jardin");
const fondo_cafeteria = document.querySelector("#fondo-cafeteria");
const lampara = document.querySelector("#lampara");
const mesa_y_barra = document.querySelector("#mesa-y-barra");
const titulo = document.querySelector("#titulo");

window.addEventListener("scroll", () => {
    let scroll = window.scrollY;

    fondo_jardin.style.bottom = scroll * 0.01 + "px";
    fondo_cafeteria.style.top = scroll * 0.1 + "px";
    lampara.style.top = scroll * 0.3 + "px";
    mesa_y_barra.style.left = scroll * 0.5 + "px";
    titulo.style.left = scroll * 0.2 + "px";
})

//-----------carrito de compras
document.addEventListener('DOMContentLoaded', function() {
    const carrito = [];

    function renderCarrito() {
        const carritoItems = document.getElementById('carrito-items');
        carritoItems.innerHTML = '';
        let total = 0;
        carrito.forEach((producto, index) => {
            const li = document.createElement('li');
            const img = document.createElement('img');
            img.src = producto.image;
            img.alt = producto.name;
            img.style.width = '50px';
            img.style.height = '50px';
            li.appendChild(img);
            li.appendChild(document.createTextNode(` ${producto.name} - ${producto.price} USD `));
            const removeButton = document.createElement('button');
            removeButton.textContent = 'Eliminar';
            removeButton.addEventListener('click', () => {
                carrito.splice(index, 1);
                renderCarrito();
            });
            li.appendChild(removeButton);
            carritoItems.appendChild(li);
            total += parseFloat(producto.price);
        });
        document.getElementById('carrito-total').textContent = `Total: ${total.toFixed(2)} USD`;
    }

    document.querySelectorAll('.add-to-cart').forEach(button => {
        button.addEventListener('click', (event) => {
            const id = event.target.getAttribute('data-id');
            const name = event.target.getAttribute('data-name');
            const price = event.target.getAttribute('data-price');
            const image = event.target.getAttribute('data-image');
            carrito.push({ id, name, price, image });
            renderCarrito();
        });
    });
});