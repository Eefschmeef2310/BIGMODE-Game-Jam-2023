extends Node

@export var speed_values: Array[int]
@export var max_air_jumps_values: Array[int]

func _ready():
	update_upgrades("")
	UpgradeManager.upgrade_purchased.connect(update_upgrades)

func update_upgrades(_upgrade):
	var player = get_parent()
	var lvl = 0
	
	# Frictionless Soles
	lvl = UpgradeManager.get_upgrade_level("Frictionless Soles")
	player.max_speed = speed_values[lvl]
	
	# Air Compressors
	lvl = UpgradeManager.get_upgrade_level("Air Compressors")
	player.max_air_jumps = max_air_jumps_values[lvl]
