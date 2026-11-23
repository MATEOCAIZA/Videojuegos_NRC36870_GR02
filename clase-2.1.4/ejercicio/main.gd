extends Control

var estado: Label
var teclado: Label
var botones: Label
var movimiento: Label

func _ready() -> void:
	var columna := VBoxContainer.new()
	columna.position = Vector2(40, 32)
	columna.size = Vector2(1020, 630)
	columna.add_theme_constant_override("separation", 20)
	add_child(columna)
	_fila(columna, "GRUPO 2  /  CLASES DE INPUTEVENT", 30)
	_fila(columna, "Pulsa una tecla, haz clic, gira la rueda y mueve el ratón.", 21)
	estado = _fila(columna, "Último evento: esperando entrada", 22)
	teclado = _fila(columna, "TECLADO\nSin eventos", 21)
	botones = _fila(columna, "BOTÓN / RUEDA\nSin eventos", 21)
	movimiento = _fila(columna, "MOVIMIENTO\nSin eventos", 21)

func _fila(padre: Node, texto: String, tamano: int) -> Label:
	var etiqueta := Label.new()
	etiqueta.text = texto
	etiqueta.add_theme_font_size_override("font_size", tamano)
	etiqueta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	etiqueta.mouse_filter = Control.MOUSE_FILTER_IGNORE
	padre.add_child(etiqueta)
	return etiqueta

func _input(event: InputEvent) -> void:
	estado.text = "Último evento: %s | device: %d" % [event.get_class(), event.device]
	if event is InputEventKey:
		teclado.text = "InputEventKey | tecla: %s\npressed: %s | echo: %s | physical_keycode: %d" % [OS.get_keycode_string(event.keycode), event.pressed, event.echo, event.physical_keycode]
	elif event is InputEventMouseButton:
		var tipo := "botón"
		if event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN, MOUSE_BUTTON_WHEEL_LEFT, MOUSE_BUTTON_WHEEL_RIGHT]:
			tipo = "rueda"
		botones.text = "InputEventMouseButton | %s: %d\npressed: %s | position: %s | double_click: %s" % [tipo, event.button_index, event.pressed, event.position, event.double_click]
	elif event is InputEventMouseMotion:
		movimiento.text = "InputEventMouseMotion\nposition: %s | relative: %s | button_mask: %d" % [event.position, event.relative, event.button_mask]
		
