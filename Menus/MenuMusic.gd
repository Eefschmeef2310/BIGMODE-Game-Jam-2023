extends Node

func _ready():
	if !MusicManager.get_node("MainStream").playing:
		MusicManager.play_menu_music()
