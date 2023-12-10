extends Node

@export var health_values: Array[int]

func _ready():
	upgrade_set_health("")
	UpgradeManager.upgrade_purchased.connect(upgrade_set_health)

func upgrade_set_health(_upgrade):
	var previous_max_health = get_parent().max_health
	var lvl = UpgradeManager.get_upgrade_level("Armor")
	get_parent().max_health = health_values[lvl]
	get_parent().health += get_parent().max_health - previous_max_health
