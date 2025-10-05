extends Node

func _process(_delta):
	if Input.is_action_just_pressed("fscreen_toggle"):
		var mode := DisplayServer.window_get_mode()
		var is_window: bool = mode != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN if is_window else DisplayServer.WINDOW_MODE_WINDOWED)
