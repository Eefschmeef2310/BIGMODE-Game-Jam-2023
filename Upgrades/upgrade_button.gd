extends Control

@export var texture_default: Texture
@export var texture_hover: Texture
@export var texture_locked: Texture

var is_mouse_hovered = false

func _ready():
	_on_mouse_exited()
	
func set_data(upgrade):
	get_node("Name").text = upgrade.name
	if upgrade.level < upgrade.costs.size():
		get_node("Description").text = upgrade.descriptions[upgrade.level]
		get_node("Cost").text = "$" + str(upgrade.costs[upgrade.level])
	else:
		get_node("Description").text = ""
		get_node("Cost").text = ":)"
	
	if upgrade.level <= 0:
		get_node("Level").text = "Unpurchased"
	else:
		get_node("Level").text = "Level " + str(upgrade.level)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if UpgradeManager.purchase_upgrade($Name.text):
			set_data(UpgradeManager.get_upgrade($Name.text))
			_on_mouse_entered()
		print("click!")
	
func _on_mouse_entered():
	is_mouse_hovered = true
	var upgrade = UpgradeManager.get_upgrade($Name.text)
	if upgrade and (upgrade.level < upgrade.costs.size() - 1 and GameManager.gears <= upgrade.costs[upgrade.level]) or upgrade.level >= upgrade.costs.size():
		$bg.texture = texture_locked
	else:
		$bg.texture = texture_hover
	print("gaming")

func _on_mouse_exited():
	is_mouse_hovered = false
	var upgrade = UpgradeManager.get_upgrade($Name.text)
	if upgrade and (upgrade.level < upgrade.costs.size() - 1 and GameManager.gears <= upgrade.costs[upgrade.level]) or upgrade.level >= upgrade.costs.size():
		$bg.texture = texture_locked
	else:
		$bg.texture = texture_default
	print("not gaming")
