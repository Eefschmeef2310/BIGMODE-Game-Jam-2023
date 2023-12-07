extends NinePatchRect

@export var upgrade_scene: PackedScene

func _ready():
	for upgrade in UpgradeManager.upgrades:
		var upgrade_button = upgrade_scene.instantiate()
		upgrade_button.set_data(upgrade)
		$ScrollContainer/Upgrades.add_child(upgrade_button)
