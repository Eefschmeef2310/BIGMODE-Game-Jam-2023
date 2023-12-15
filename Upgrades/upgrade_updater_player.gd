extends Node

@export var speed_values: Array[int]
@export var max_air_jumps_values: Array[int]
@export var max_hover_time_values: Array[float]
@export var magnet_radius_value: Array[float]
@export var max_invis_time_values: Array[float]

func _ready():
	update_upgrades("")
	UpgradeManager.upgrade_purchased.connect(update_upgrades)

func update_upgrades(_upgrade):
	var player = get_parent()
	var lvl = 0
	
	# Frictionless Soles
	lvl = UpgradeManager.get_upgrade_level("Frictionless Soles")
	player.max_speed = speed_values[lvl]
	update_line(lvl)
	
	# Air Compressors
	lvl = UpgradeManager.get_upgrade_level("Air Compressors")
	player.max_air_jumps = max_air_jumps_values[lvl]
	
	# Jetpack
	lvl = UpgradeManager.get_upgrade_level("Jetpack")
	player.max_hover_time = max_hover_time_values[lvl]
	
	# Scrap Magnet
	lvl = UpgradeManager.get_upgrade_level("Scrap Magnet")
	player.magnet_radius = magnet_radius_value[lvl]
	
	# Invisibility Cloak
	lvl = UpgradeManager.get_upgrade_level("Invisibility Cloak")
	player.max_invis_time = max_invis_time_values[lvl]
	player.invis_recovering = true

func update_line(lvl):
	if lvl > 0: #If speed is updated
		#Turn on line
		$"../Line2D".process_mode = Node.PROCESS_MODE_INHERIT
