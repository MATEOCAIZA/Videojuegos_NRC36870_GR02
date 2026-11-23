extends SceneTree

func _initialize() -> void:
	call_deferred("probar")

func probar() -> void:
	var panel = load("res://main.tscn").instantiate()
	root.add_child(panel)
	var tecla := InputEventKey.new()
	tecla.pressed = true
	panel._input(tecla)
	tecla.echo = true
	panel._input(tecla)
	tecla.pressed = false
	panel._input(tecla)
	assert(panel.teclas == 1)
	var clic := InputEventMouseButton.new()
	clic.button_index = MOUSE_BUTTON_LEFT
	clic.pressed = true
	panel._input(clic)
	clic.pressed = false
	panel._input(clic)
	clic.pressed = true
	clic.button_index = MOUSE_BUTTON_RIGHT
	panel._input(clic)
	clic.button_index = MOUSE_BUTTON_WHEEL_UP
	panel._input(clic)
	clic.button_index = MOUSE_BUTTON_WHEEL_DOWN
	panel._input(clic)
	panel._input(InputEventMouseMotion.new())
	assert(panel.clics == 1 and panel.rueda == 2)
	print("OK: eco y liberación ignorados; clics y rueda separados")
	quit()
