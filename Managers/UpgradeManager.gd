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
	#var goose = upgrade_state() # TODO remove
	#print(goose)

func purchase_upgrade(upgrade_name: String):
	for upgrade in upgrades:
		if upgrade.name == upgrade_name:
			if upgrade.level < upgrade.costs.size() and GameManager.gears >= upgrade.costs[upgrade.level]:
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

func get_upgrade(upgrade_name: String):
	for upgrade in upgrades:
		if upgrade.name == upgrade_name:
			return upgrade
	return null

func reset_upgrades():
	for upgrade in upgrades:
		upgrade.level = 0
	upgrade_purchased.emit("")
	
func upgrade_state(): #method for use by airtable system
	var state : String = ""
	for upgrade in upgrades:
		state += upgrade.name + "(" + str(upgrade.level) + ")\n"
		#print(upgrade.name + "(" + str(upgrade.level) + ")")
		
	return state
