# Reto — Contador selectivo
Abre `reto/inicio/project.godot`.

Transforma los eventos en un marcador de teclas, clics izquierdos y rueda vertical. Usa el tipo y las propiedades del evento para contar únicamente entradas válidas.

## Tres requisitos comprobables
1. `Teclas` aumenta una vez por pulsación inicial: soltar o mantener una tecla (echo) no añade puntos.
2. `Clics izquierdos` aumenta solo al presionar el botón izquierdo; soltarlo, mover el ratón o usar el botón derecho no lo modifica.
3. `Rueda` aumenta por cada evento de rueda vertical recibido, sin modificar el contador de clics.

## Comprobación en pantalla
Reinicia. Pulsa y suelta A una vez: teclas = 1. Mantén B un segundo y suéltala: teclas = 2 aunque haya eco. Haz un clic izquierdo: clics = 1. Haz un clic derecho y mueve el ratón: no cambia nada. Gira la rueda: solo aumenta rueda. El número de eventos de rueda depende del dispositivo; no se exige un evento por giro físico.