extends Control

var teclas: int = 0
var clics: int = 0
var rueda: int = 0
var marcador: Label

func _ready() -> void:
	marcador = Label.new()
	marcador.position = Vector2(45, 60)
	marcador.add_theme_font_size_override("font_size", 28)
	add_child(marcador)
	actualizar()

func actualizar() -> void:
	marcador.text = "RETO  /  CONTADOR SELECTIVO\n\nTeclas: %d\nClics izquierdos: %d\nRueda: %d" % [teclas, clics, rueda]

func _input(event: InputEvent) -> void:
	# Solo contar pulsaciones iniciales; ignorar liberaciones y eco.
	if event is InputEventKey:
		if event.pressed and not event.echo:
			teclas += 1
	elif event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_LEFT:
				clics += 1
			elif event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
				rueda += 1
	# MouseMotion y botón derecho no cambian los contadores.
	actualizar()
