extends Node

@export var speed_values: Array[int]

func _ready():
	update_upgrades("")
	UpgradeManager.upgrade_purchased.connect(update_upgrades)

func update_upgrades(_upgrade):
	var player = get_parent()
	var lvl = 0
	
	# Armor
	lvl = UpgradeManager.get_upgrade_level("Frictionless Soles")
	player.SPEED = speed_values[lvl]
