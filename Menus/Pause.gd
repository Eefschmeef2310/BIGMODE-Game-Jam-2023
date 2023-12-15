extends ColorRect

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	ScoreManager.countTime = false

func _on_continue_button_pressed():
	GameManager.game_paused = false
	ScoreManager.countTime = true

func _on_menu_button_pressed():
	GameManager.game_paused = false
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
	ScoreManager.countTime = false
