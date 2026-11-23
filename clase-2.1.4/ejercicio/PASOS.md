# Inspector de InputEvent

## Preparación antes de clase
Abrir `inicio/project.godot`. Ejecutar una vez para comprobar la interfaz. Abrir también la versión resuelta para usarla como respaldo. No dedicar la demostración a escribir la interfaz: el foco es la clasificación de eventos.

## Pasos a seguir
1. Ejecutar la escena. Mostrar que las tres filas están esperando eventos y localizar `_input(event: InputEvent)` al final de `main.gd`.
2. Reemplazar `pass` por la actualización de `estado.text` que muestra `event.get_class()` y `event.device`. Ejecutar y observar cómo cambia la clase.
3. Escribir la rama `if event is InputEventKey:`. Mostrar la tecla con `OS.get_keycode_string(event.keycode)`, `event.pressed`, `event.echo` y `event.physical_keycode`. Pulsar y soltar A. Mantener B; el eco depende de la configuración del sistema operativo.
4. Añadir `elif event is InputEventMouseButton:`. Inicializar `tipo` como `"botón"`; si el índice está en las cuatro constantes `MOUSE_BUTTON_WHEEL_*`, cambiarlo a `"rueda"`. Mostrar `button_index`, `pressed`, `position` y `double_click`.
5. Añadir `elif event is InputEventMouseMotion:` y mostrar `position`, `relative` y `button_mask`.
6. Ejecutar. Demostrar las tres clases y preguntar cuál tiene `echo`. Mover el ratón no borra la fila de teclado porque cada rama escribe en una etiqueta distinta.

El bloque completo de referencia está en `../main.gd` respecto de la carpeta `inicio`.

## Comprobaciones
| Acción | Clase | Evidencia |
|---|---|---|
| Pulsar A | InputEventKey | tecla A, pressed true |
| Soltar A | InputEventKey | pressed false |
| Mantener B | InputEventKey | echo true cuando el sistema repite |
| Clic izquierdo | InputEventMouseButton | button_index 1 y estado |
| Rueda vertical | InputEventMouseButton | texto rueda, índice 4 o 5 |
| Mover ratón | InputEventMouseMotion | position y relative cambian |

## Explicación técnica
`get_class()` devuelve el nombre concreto. `is` comprueba si el objeto pertenece a una clase o hereda de ella. No identificar el tipo por `device`: este es un identificador, no la clase. `position` es una ubicación en el viewport; `relative` representa desplazamiento. El panel usa `_input` para observar también entradas que podrían dirigirse a la interfaz.

Si el juego no responde: detener, volver a ejecutar y hacer clic dentro de su ventana. Si la fila no es visible, usar el tamaño de ventana previsto, 1100 × 700.
