extends Node2D

signal toggle_is_game_paused(isPaused: bool)
signal game_over_signal()
signal end_reached_signal()

var tank_mode := true:
	get:
		return tank_mode

var tank_position: Vector2

var camera: Camera2D

var gears: int = 0:
	set(value):
		if value < gears: #gears have been spent
			ScoreManager.gearsSpent += gears-value
			#print("GEARS SPENT")
		gears = value
		UpgradeManager.upgrade_purchased.emit(null)

var game_paused : bool = false:
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		toggle_is_game_paused.emit(game_paused)
		
var game_over : bool = false:
	set(value):
		AirtableManager.PullAndUpload()
		#await get_tree().create_timer(1.0).timeout
		#await AirtableManager.PullAndUpload()._on_request_completed
		
		game_over = value
		get_tree().paused = game_over
		game_over_signal.emit()
		

var end_reached : bool = false:
	set(value):
		end_reached = value
		AirtableManager.PullAndUpload()
		get_tree().paused = end_reached
		end_reached_signal.emit()
		

func _input(_event):
	if Input.is_action_just_pressed("pause") and !game_over:
		if get_tree().current_scene.name == "World":
			game_paused = !game_paused
		else:
			get_tree().quit()

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_game():
	reset_gears()
	UpgradeManager.reset_upgrades()
	get_tree().change_scene_to_file("res://Levels/world.tscn")
	ScoreManager.countTime = true
	ScoreManager.elapsedTime = 0.0

func reset_gears():
	gears = 0
	ScoreManager.gearsSpent = 0

func drop_gears(pos: Vector2, amount: int):
	var values = [1,1,1,5,10]
	var gear_scene = load("res://Objects/Pickups/Gear.tscn")
	for n in amount:
		var gear = gear_scene.instantiate()
		gear.value = values[randi_range(0, values.size() - 1)]
		gear.position = pos
		gear.position.x += randf() * 50
		get_tree().get_root().call_deferred("add_child", gear)
		

#var current_module_count: int = 0
#var max_module_count: int = 5
