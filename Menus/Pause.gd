extends ColorRect

func _ready():
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.connect("toggle_is_game_paused", _on_game_paused)

func _on_game_paused(isPaused):
	if isPaused:
		show()
	else:
		hide()

func _on_continue_button_pressed():
	GameManager.game_paused = false

func _on_menu_button_pressed():
	GameManager.game_paused = false
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
