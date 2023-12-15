extends Node

@export var health_values: Array[int]
@export var extra_bullets_values: Array[int]
@export var extra_bullet_angle_offset_values: Array[float]
@export var fire_rate_values: Array[float]
@export var has_rockets_values: Array[bool]
@export var rocket_level_values: Array[int]

func _ready():
	update_upgrades("")
	UpgradeManager.upgrade_purchased.connect(update_upgrades)

func update_upgrades(_upgrade):
	var tank = get_parent()
	var lvl = 0
	
	# Armor
	lvl = UpgradeManager.get_upgrade_level("Armor")
	var previous_max_health = tank.max_health
	tank.max_health = health_values[lvl]
	tank.health += tank.max_health - previous_max_health
	
	# Extra Artillery
	lvl = UpgradeManager.get_upgrade_level("Extra Artillery")
	tank.extra_bullets = extra_bullets_values[lvl]
	tank.extra_bullet_angle_offset = extra_bullet_angle_offset_values[lvl]
	
	#Frequent Artillery
	lvl = UpgradeManager.get_upgrade_level("Frequent Artillery")
	tank.fire_rate = fire_rate_values[lvl]
	
	# Explosive Artillery
	lvl = UpgradeManager.get_upgrade_level("Explosive Artillery")
	tank.has_rockets = has_rockets_values[lvl]
	tank.rocket_level = rocket_level_values[lvl]
	
	# Ramming Artillery
	lvl = UpgradeManager.get_upgrade_level("Ramming Artillery")
	tank.get_node("Sprites/FrontSpikes").visible = false
	tank.get_node("Sprites/RotarySystem").visible = false
	tank.get_node("Sprites/RotarySystem").active_in_player_mode = false
	if lvl >= 1:
		tank.get_node("Sprites/FrontSpikes").visible = true
		if lvl >= 2:
			tank.get_node("Sprites/RotarySystem").visible = true
			if lvl >= 3:
				tank.get_node("Sprites/RotarySystem").active_in_player_mode = true
