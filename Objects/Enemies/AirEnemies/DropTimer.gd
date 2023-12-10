extends Timer

signal addItem(item)

var drop_scene: PackedScene = preload("res://Objects/Enemies/AirEnemies/LakituDrop.tscn")
		
#region dropping	
func spawnDrop():
	var drop = drop_scene.instantiate()
	drop.position = $"../DropMarker".global_position
	addItem.emit(drop)

func _on_timeout():
	spawnDrop()
	start()
#endregion
