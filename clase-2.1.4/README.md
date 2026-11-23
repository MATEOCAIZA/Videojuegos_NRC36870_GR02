## Clases de InputEvent
**Integrantes:** Eduardo Mortensen, Samir Mideros y Mateo Llumigusin.
**Asignatura:** Desarrollo de Videojuegos.

## Archivos
- `Presentacion_Grupo02.pdf`: 10 diapositivas en pdf.
- `Actividad03_Grupo02.pdf`: Investigación, código explicado y fuentes.
- `ejercicio/project.godot`: demostración resuelta.
- `ejercicio/inicio/project.godot`: interfaz del programa.
- `ejercicio/PASOS.md`: instrucciones para ejecutar el programa.
- `reto/RETO.md`: enunciado y criterios establecidos.
- `reto/inicio/project.godot`: proyecto para los otros grupos.
- `reto/solucion/project.godot`: solución ejecutable.
- `reto/solucion/PISTA_Y_SOLUCION.md`: solucion explicada para el reto.

## Ejecutar
1. Instalar o abrir Godot **4.7.x**; se verificó con **4.7.2**.
2. Descomprimir el ZIP, conservando la carpeta `clase-2.1.4`.
3. En el gestor de Godot seleccionar **Importar** y elegir `ejercicio/project.godot`.
4. Abrir el proyecto y pulsar **F5**. Si solicita escena principal, elegir `main.tscn`.
5. Dar foco a la ventana del juego. Pulsar y soltar A, mantener B, hacer clic, girar la rueda y mover el ratón.
6. Observar el nombre de la clase y sus propiedades. Las tres filas conservan su último dato; la cabecera muestra el último evento global.
7. Para el reto, importar proyecto independiente `reto/inicio/project.godot`. La solución se abre desde la propia carpeta.

No se requieren recursos externos, complementos, mando o conexión a Internet para la demostración. La interfaz se crea por código, por eso no hay nodos Label adicionales en la escena del editor.

## Validación realizada
- Ejecución de pruebas en Godot `4.7.2.stable.official.ed1daf0bf` en modo headless.
- Ejercicio: eventos sintéticos enviados mediante `Input.parse_input_event` y vaciado de la cola; se comprobaron teclado, liberación, clic, rueda y movimiento.
- Reto: comprobación de contadores para pulsación, eco, liberación, clic izquierdo/derecho, rueda y movimiento.
- Esta validación automatizada no sustituye el ensayo presencial con el teclado, ratón y proyector que se usarán en clase. No se comprobó hardware físico de mando ni pantalla táctil.

## Ensayo y entrega
1. Ensayar la clase con `GUION.md` y cronómetro. Todos deben intervenir.
2. Distribuir únicamente `reto/inicio` y `reto/RETO.md` durante el reto; conservar la solución hasta el cierre.
3. Crear el repositorio del grupo cuando esté disponible y colocar esta carpeta en su raíz.
4. Desde un clon del repositorio, añadir y confirmar:
```sh
git add clase-2.1.4
git commit -m "Entrega clase 2.1.4, grupo 2"
git push
```
Estos comandos suponen que ya se configuraron Git, la identidad del autor y el remoto. No se ha creado ni publicado un repositorio remoto con esta entrega.

La página 4 de la guía proporcionada estaba vacía salvo por el pie de página. El plan incluido organiza todos los apartados exigidos en una plantilla propia.
