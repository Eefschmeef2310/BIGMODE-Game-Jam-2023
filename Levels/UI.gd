extends CanvasLayer

#Preloads
var pause_screen_scene: PackedScene = preload("res://Menus/Pause.tscn")
var game_over_screen_scene: PackedScene = preload("res://Menus/GameOverScreen.tscn")
var win_screen_scene: PackedScene = preload("res://Menus/WinScreen.tscn")

var pause_screen
var game_over_screen
var win_screen

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	GameManager.connect("toggle_is_game_paused", _on_game_paused)
	GameManager.connect("game_over_signal", _on_game_over)
	GameManager.connect("end_reached_signal", _on_end_reached)
	
	ScoreManager.progress_bar = $ProgressBar
	
func _on_game_paused(isPaused):
	if isPaused:
		pause_screen = pause_screen_scene.instantiate()
		add_child(pause_screen)
	elif pause_screen:
		pause_screen.queue_free()

func _on_game_over():
	game_over_screen = game_over_screen_scene.instantiate()
	add_child(game_over_screen)

func _on_end_reached():
	win_screen = win_screen_scene.instantiate()
	ScoreManager.calculateScore()
	add_child(win_screen)
