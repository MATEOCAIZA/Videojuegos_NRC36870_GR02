extends Node2D
## Tablero 2D: un muñequito en una cuadrícula que reacciona a las tres clases
## de InputEvent de la presentación (analogía de controles tipo Minecraft).
##   InputEventKey         -> WASD / flechas mueven una casilla, Espacio salta
##   InputEventMouseMotion -> relative.x gira la mirada del personaje
##   InputEventMouseButton -> clic izq. pica un bloque, clic der. lo coloca,
##                            la rueda cambia la ranura de la barra rápida

const COLUMNAS := 8
const FILAS := 8
const CELDA := 52
const COLORES := [Color("8d6e63"), Color("9e9e9e"), Color("66bb6a"), Color("42a5f5"), Color("ffca28")]
const NOMBRES := ["Tierra", "Piedra", "Hierba", "Agua", "Arena"]

var celda_personaje := Vector2i(3, 4)
var pos_dibujo := Vector2.ZERO      # posición animada del personaje, en píxeles
var salto := 0.0                    # desplazamiento vertical durante el salto
var mirada := 0.0                   # ángulo en radianes (lo controla MouseMotion)
var ranura := 0                     # ranura seleccionada con la rueda
var bloques := {}                   # Vector2i -> índice de color
var golpe_celda := Vector2i(-1, -1)
var golpe_t := 0.0
var ultimo := "Esperando entrada…"
var tween_mov: Tween
var tween_salto: Tween

func _ready() -> void:
	pos_dibujo = _centro(celda_personaje)
	for c in [Vector2i(1, 1), Vector2i(2, 1), Vector2i(6, 2), Vector2i(5, 6), Vector2i(1, 6), Vector2i(6, 6)]:
		bloques[c] = 1

func _process(delta: float) -> void:
	golpe_t = maxf(golpe_t - delta * 3.0, 0.0)
	queue_redraw()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		# Entrada discreta: solo la pulsación inicial (sin soltar ni eco).
		if event.pressed and not event.echo:
			match event.keycode:
				KEY_W, KEY_UP:
					_mover(Vector2i.UP, "W")
				KEY_S, KEY_DOWN:
					_mover(Vector2i.DOWN, "S")
				KEY_A, KEY_LEFT:
					_mover(Vector2i.LEFT, "A")
				KEY_D, KEY_RIGHT:
					_mover(Vector2i.RIGHT, "D")
				KEY_SPACE:
					_saltar()
	elif event is InputEventMouseButton:
		if event.pressed:
			var c := _celda_de(event.position)
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					_picar(c)
				MOUSE_BUTTON_RIGHT:
					_colocar(c)
				MOUSE_BUTTON_WHEEL_UP:
					ranura = (ranura - 1 + COLORES.size()) % COLORES.size()
					ultimo = "MouseButton (rueda %d) → ranura: %s" % [event.button_index, NOMBRES[ranura]]
				MOUSE_BUTTON_WHEEL_DOWN:
					ranura = (ranura + 1) % COLORES.size()
					ultimo = "MouseButton (rueda %d) → ranura: %s" % [event.button_index, NOMBRES[ranura]]
	elif event is InputEventMouseMotion:
		# Rotación continua usando el desplazamiento relativo, no la posición.
		mirada = wrapf(mirada + event.relative.x * 0.02, -PI, PI)
		ultimo = "MouseMotion → relative.x = %.1f, mirada %d°" % [event.relative.x, roundi(rad_to_deg(mirada))]

func _mover(dir: Vector2i, tecla: String) -> void:
	mirada = Vector2(dir).angle()
	var destino := celda_personaje + dir
	if not _dentro(destino) or bloques.has(destino):
		ultimo = "Key (%s) → bloqueado" % tecla
		return
	celda_personaje = destino
	ultimo = "Key (%s) → casilla %s" % [tecla, destino]
	if tween_mov:
		tween_mov.kill()
	tween_mov = create_tween()
	tween_mov.tween_property(self, "pos_dibujo", _centro(destino), 0.12)

func _saltar() -> void:
	ultimo = "Key (Espacio) → salto"
	if tween_salto and tween_salto.is_running():
		return
	tween_salto = create_tween()
	tween_salto.tween_property(self, "salto", -22.0, 0.15).set_ease(Tween.EASE_OUT)
	tween_salto.tween_property(self, "salto", 0.0, 0.15).set_ease(Tween.EASE_IN)

func _picar(c: Vector2i) -> void:
	if not _dentro(c):
		return
	golpe_celda = c
	golpe_t = 1.0
	if bloques.has(c):
		bloques.erase(c)
		ultimo = "MouseButton (izq.) → picó %s" % [c]
	else:
		ultimo = "MouseButton (izq.) → casilla vacía %s" % [c]

func _colocar(c: Vector2i) -> void:
	if not _dentro(c) or bloques.has(c) or c == celda_personaje:
		return
	bloques[c] = ranura
	ultimo = "MouseButton (der.) → colocó %s en %s" % [NOMBRES[ranura], c]

func _dentro(c: Vector2i) -> bool:
	return c.x >= 0 and c.y >= 0 and c.x < COLUMNAS and c.y < FILAS

func _centro(c: Vector2i) -> Vector2:
	return Vector2(c.x * CELDA + CELDA / 2.0, c.y * CELDA + CELDA / 2.0)

func _celda_de(posicion_viewport: Vector2) -> Vector2i:
	var p := to_local(posicion_viewport)
	return Vector2i(floori(p.x / CELDA), floori(p.y / CELDA))

func _draw() -> void:
	var fuente := ThemeDB.fallback_font
	var ancho := COLUMNAS * CELDA
	var alto := FILAS * CELDA
	draw_string(fuente, Vector2(0, -14), "ESCENARIO: " + ultimo, HORIZONTAL_ALIGNMENT_LEFT, -1, 15, Color("ffd54f"))

	# Suelo y cuadrícula
	draw_rect(Rect2(0, 0, ancho, alto), Color("1b2a3a"))
	for x in COLUMNAS + 1:
		draw_line(Vector2(x * CELDA, 0), Vector2(x * CELDA, alto), Color(1, 1, 1, 0.12))
	for y in FILAS + 1:
		draw_line(Vector2(0, y * CELDA), Vector2(ancho, y * CELDA), Color(1, 1, 1, 0.12))

	# Bloques
	for c in bloques:
		var r := Rect2(Vector2(c) * CELDA + Vector2(2, 2), Vector2(CELDA - 4, CELDA - 4))
		var col: Color = COLORES[bloques[c]]
		draw_rect(r, col)
		draw_rect(r, col.darkened(0.4), false, 2.0)

	# Destello al picar
	if golpe_t > 0.0 and _dentro(golpe_celda):
		draw_rect(Rect2(Vector2(golpe_celda) * CELDA, Vector2(CELDA, CELDA)), Color(1, 1, 1, golpe_t * 0.6))

	_dibujar_personaje(pos_dibujo)

	# Barra rápida (ranuras que cambia la rueda)
	var y0 := alto + 14
	for i in COLORES.size():
		var r := Rect2(Vector2(i * 48, y0), Vector2(40, 40))
		draw_rect(r, Color("263238"))
		draw_rect(r.grow(-6), COLORES[i])
		draw_rect(r, Color.WHITE if i == ranura else Color(1, 1, 1, 0.25), false, 3.0 if i == ranura else 1.0)
	draw_string(fuente, Vector2(COLORES.size() * 48 + 6, y0 + 26), NOMBRES[ranura], HORIZONTAL_ALIGNMENT_LEFT, -1, 16, Color.WHITE)

	var ayuda := "WASD/flechas: mover · Espacio: saltar · Ratón: mirar\nClic izq.: picar · Clic der.: colocar · Rueda: ranura"
	draw_multiline_string(fuente, Vector2(0, y0 + 64), ayuda, HORIZONTAL_ALIGNMENT_LEFT, ancho, 13, -1, Color(1, 1, 1, 0.7))

func _dibujar_personaje(base: Vector2) -> void:
	var p := base + Vector2(0, salto)
	var dir := Vector2.from_angle(mirada)

	# Sombra (se encoge al saltar)
	var s := 1.0 + salto / 44.0
	draw_set_transform(base + Vector2(0, 20), 0.0, Vector2(1.0, 0.35) * s)
	draw_circle(Vector2.ZERO, 14.0, Color(0, 0, 0, 0.35))
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)

	# Cono de mirada
	draw_colored_polygon(PackedVector2Array([
		p + Vector2(0, -12),
		p + Vector2(0, -12) + dir.rotated(0.35) * 34.0,
		p + Vector2(0, -12) + dir.rotated(-0.35) * 34.0,
	]), Color(1, 0.84, 0.3, 0.25))

	# Piernas y brazos
	var piel := Color("ffcc99")
	draw_line(p + Vector2(-5, 10), p + Vector2(-7, 21), Color("37474f"), 4.0)
	draw_line(p + Vector2(5, 10), p + Vector2(7, 21), Color("37474f"), 4.0)
	draw_line(p + Vector2(-9, 0), p + Vector2(-15, 10), piel, 3.0)
	draw_line(p + Vector2(9, 0), p + Vector2(15, 10), piel, 3.0)

	# Cuerpo y cabeza
	draw_rect(Rect2(p + Vector2(-9, -3), Vector2(18, 15)), Color("29b6f6"))
	draw_circle(p + Vector2(0, -12), 10.0, piel)

	# Ojos que siguen la mirada
	for lado in [-4.0, 4.0]:
		var ojo := p + Vector2(lado, -13)
		draw_circle(ojo, 3.0, Color.WHITE)
		draw_circle(ojo + dir * 1.5, 1.5, Color.BLACK)
