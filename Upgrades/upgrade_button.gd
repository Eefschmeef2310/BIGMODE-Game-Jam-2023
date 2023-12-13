extends Control

@export var texture_default: Texture
@export var texture_hover: Texture
@export var texture_locked: Texture

@export var texture_level_false: Texture
@export var texture_level_true: Texture

var is_mouse_hovered = false

func _ready():
	_on_mouse_exited()
	UpgradeManager.upgrade_purchased.connect(refresh)

func refresh(_upgrade):
	set_data(UpgradeManager.get_upgrade($Name.text))
	_on_mouse_exited()

func set_data(upgrade):
	get_node("Name").text = upgrade.name
	if upgrade.level < upgrade.costs.size():
		get_node("Description").text = upgrade.descriptions[upgrade.level]
		get_node("Cost").text = "$" + str(upgrade.costs[upgrade.level])
	else:
		get_node("Description").text = ""
		get_node("Cost").text = ""
	
	var current_level = 1
	for circle in $Levels.get_children():
		if current_level <= upgrade.level:
			circle.texture = texture_level_true
		else:
			circle.texture = texture_level_false
		current_level += 1
	
	#if upgrade.level <= 0:
		#get_node("Level").text = "Level 1"
	#elif upgrade.level >= upgrade.costs.size():
		#get_node("Level").text = "MAX"
	#else:
		#get_node("Level").text = "Level " + str(upgrade.level + 1)

func set_visibility(current_category: String):
	var upgrade = UpgradeManager.get_upgrade($Name.text)
	if !upgrade or upgrade.category != current_category:
		visible = false
	else:
		visible = true

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if UpgradeManager.purchase_upgrade($Name.text):
			refresh("")
	
func _on_mouse_entered():
	is_mouse_hovered = true
	var upgrade = UpgradeManager.get_upgrade($Name.text)
	if !upgrade or upgrade.level >= upgrade.costs.size() or GameManager.gears < upgrade.costs[upgrade.level]:
		$bg.texture = texture_locked
	else:
		$bg.texture = texture_hover

func _on_mouse_exited():
	is_mouse_hovered = false
	var upgrade = UpgradeManager.get_upgrade($Name.text)
	if !upgrade or upgrade.level >= upgrade.costs.size() or GameManager.gears < upgrade.costs[upgrade.level]:
		$bg.texture = texture_locked
	else:
		$bg.texture = texture_default
