extends NinePatchRect

@export var upgrade_scene: PackedScene

func _ready():
	for upgrade in UpgradeManager.upgrades:
		var upgrade_button = upgrade_scene.instantiate()
		upgrade_button.get_node("Name").text = upgrade.name
		upgrade_button.get_node("Description").text = upgrade.descriptions[upgrade.level]
		upgrade_button.get_node("Cost").text = "$" + str(upgrade.costs[upgrade.level])
		
		if upgrade.level <= 0:
			upgrade_button.get_node("Level").text = "Unpurchased"
		else:
			upgrade_button.get_node("Level").text = "Level " + str(upgrade.level)
		$ScrollContainer/Upgrades.add_child(upgrade_button)
