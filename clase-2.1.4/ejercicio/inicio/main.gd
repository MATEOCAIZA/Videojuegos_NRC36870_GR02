extends Control

# Cada fila conserva el último evento de su clase para facilitar la lectura.
var estado: Label
var teclado: Label
var botones: Label
var movimiento: Label

func _ready() -> void:
	var columna := VBoxContainer.new()
	columna.position = Vector2(30, 24)
	columna.size = Vector2(560, 650)
	columna.add_theme_constant_override("separation", 16)
	add_child(columna)
	_fila(columna, "GRUPO 2  /  CLASES DE INPUTEVENT", 26)
	_fila(columna, "Pulsa una tecla, haz clic, gira la rueda y mueve el ratón.", 18)
	estado = _fila(columna, "Último evento: esperando entrada", 19)
	teclado = _fila(columna, "TECLADO\nSin eventos", 18)
	botones = _fila(columna, "BOTÓN / RUEDA\nSin eventos", 18)
	movimiento = _fila(columna, "MOVIMIENTO\nSin eventos", 18)
	# Escenario 2D: el muñequito reacciona a las mismas tres clases de InputEvent.
	var tablero := preload("res://tablero.gd").new()
	tablero.position = Vector2(640, 70)
	add_child(tablero)

func _fila(padre: Node, texto: String, tamano: int) -> Label:
	var etiqueta := Label.new()
	etiqueta.text = texto
	etiqueta.add_theme_font_size_override("font_size", tamano)
	etiqueta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	etiqueta.mouse_filter = Control.MOUSE_FILTER_IGNORE
	padre.add_child(etiqueta)
	return etiqueta

func _input(event: InputEvent) -> void:
	# Completar en vivo: clase, dispositivo y tres ramas con is.
	pass
