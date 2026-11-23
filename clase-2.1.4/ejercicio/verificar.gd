extends SceneTree

func _initialize() -> void:
	call_deferred("probar")

func probar() -> void:
	var panel = load("res://main.tscn").instantiate()
	root.add_child(panel)
	await process_frame
	var tecla := InputEventKey.new()
	tecla.keycode = KEY_A
	tecla.physical_keycode = KEY_A
	tecla.pressed = true
	Input.parse_input_event(tecla.duplicate())
	Input.flush_buffered_events()
	assert("InputEventKey" in panel.teclado.text)
	var clic := InputEventMouseButton.new()
	clic.button_index = MOUSE_BUTTON_LEFT
	clic.pressed = true
	clic.position = Vector2(250, 180)
	Input.parse_input_event(clic.duplicate())
	Input.flush_buffered_events()
	assert("botón: 1" in panel.botones.text)
	clic.button_index = MOUSE_BUTTON_WHEEL_UP
	Input.parse_input_event(clic.duplicate())
	Input.flush_buffered_events()
	assert("rueda: 4" in panel.botones.text)
	var movimiento := InputEventMouseMotion.new()
	movimiento.position = Vector2(420, 240)
	movimiento.relative = Vector2(12, -4)
	Input.parse_input_event(movimiento)
	Input.flush_buffered_events()
	assert("InputEventMouseMotion" in panel.movimiento.text and "relative:" in panel.movimiento.text)
	tecla.pressed = false
	Input.parse_input_event(tecla.duplicate())
	Input.flush_buffered_events()
	assert("pressed: false" in panel.teclado.text)
	print("OK: teclado, liberación, clic, rueda y movimiento")
	quit()
