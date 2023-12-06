extends Node2D

func _on_tank_add_bullet(bullet):
	print('i will add')
	add_child(bullet)
