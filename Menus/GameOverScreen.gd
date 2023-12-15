extends ColorRect

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	ScoreManager.countTime = false

func _on_restart_button_pressed():
	GameManager.game_over = false
	UpgradeManager.reset_upgrades()
	GameManager.reset_gears()
	get_tree().change_scene_to_file("res://Levels/world.tscn")
	ScoreManager.countTime = true
	ScoreManager.elapsedTime = 0.0

func _on_menu_button_pressed():
	GameManager.game_over = false
	UpgradeManager.reset_upgrades()
	GameManager.reset_gears()
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
	ScoreManager.countTime = false
