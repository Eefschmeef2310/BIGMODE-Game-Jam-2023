extends Button

func _on_pressed():
	UpgradeManager.reset_upgrades()
	get_tree().change_scene_to_file("res://Levels/world.tscn")
