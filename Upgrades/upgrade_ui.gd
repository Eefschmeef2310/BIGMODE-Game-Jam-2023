extends NinePatchRect

@export var upgrade_scene: PackedScene

var current_category: String = ""

func _ready():
	for upgrade in UpgradeManager.upgrades:
		var upgrade_button = upgrade_scene.instantiate()
		upgrade_button.set_data(upgrade)
		if current_category == "":
			set_category(upgrade.category)
		upgrade_button.set_visibility(current_category)
		$ScrollContainer/Upgrades.add_child(upgrade_button)

func _process(_delta):
	$Gears.text = "Gears: " + str(GameManager.gears)

func scroll_category(direction: int):
	var i = UpgradeManager.categories.find(current_category)
	if i != -1:
		i += direction
		if i < 0:
			i = UpgradeManager.categories.size() - 1
		elif i >= UpgradeManager.categories.size():
			i = 0
		set_category(UpgradeManager.categories[i])

func set_category(new_category: String):
	current_category = new_category
	$Category/Name.text = current_category
	for button in $ScrollContainer/Upgrades.get_children():
			button.set_visibility(current_category)
