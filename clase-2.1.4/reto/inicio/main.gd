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
	# TODO: filtrar por clase y actualizar los contadores correctos.
	actualizar()
