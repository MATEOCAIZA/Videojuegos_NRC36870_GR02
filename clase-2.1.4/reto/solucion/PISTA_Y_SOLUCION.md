## Pista
Comprueba primero `event is ...`. Para teclado combina `pressed` con `not echo`. La rueda comparte clase con el clic, pero cambia `button_index`.

## Solución
Abrir `project.godot` de esta carpeta; el código resuelto está en `main.gd`. Se usa `if/elif` para que cada evento incremente solo su contador. No se lee `echo` en MouseButton ni `pressed` en MouseMotion.

## Pregunta de transferencia
¿Por qué mover el ratón no debe sumar clics? Porque MouseMotion representa desplazamiento; el botón presionado durante el movimiento está en `button_mask` y no equivale a una nueva pulsación.
