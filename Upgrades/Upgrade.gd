extends Resource
class_name Upgrade

@export var name: String
@export var category: String
@export var descriptions: PackedStringArray
@export var costs: Array[int]
@export var level: int

func _init(p_name = "Upgrade", p_category = "None", p_descriptions = [], p_costs: Array[int] = [], p_level = 0):
	name = p_name
	category = p_category
	descriptions = p_descriptions
	costs = p_costs
	level = p_level
