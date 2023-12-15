extends Button

func _on_pressed():
	UpgradeManager.reset_upgrades()
	GameManager.reset_gears()
	get_tree().change_scene_to_file("res://Levels/world.tscn")
	ScoreManager.countTime = true
	ScoreManager.elapsedTime = 0.0
