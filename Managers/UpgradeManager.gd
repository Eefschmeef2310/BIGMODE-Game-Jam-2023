extends Node

@export var upgrades: Array[Upgrade]
var categories: PackedStringArray

signal upgrade_purchased(Upgrade)

func _ready():
	var str_u = "Upgrades: "
	var str_c = "Categories: "
	
	for upgrade in upgrades:
		if !categories.has(upgrade.category):
			categories.append(upgrade.category)
			
			str_c += upgrade.category + ", "
		str_u += upgrade.name + ", "
		
	print(str_u)
	print(str_c)

func purchase_upgrade(upgrade_name: String):
	for upgrade in upgrades:
		if upgrade.name == upgrade_name:
			if upgrade.level <= upgrade.costs.size() and GameManager.gears >= upgrade.costs[upgrade.level]:
				# Purchase upgrade
				GameManager.gears -= upgrade.costs[upgrade.level]
				upgrade.level += 1
				upgrade_purchased.emit(upgrade)
				return true
			else:
				# Purchase failed
				return false
	return false

func get_upgrade_level(upgrade_name: String):
	for upgrade in upgrades:
		if upgrade.name == upgrade_name:
			return upgrade.level
	return 0
