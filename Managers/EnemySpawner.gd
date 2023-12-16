extends Node2D

const enemySmallPath = preload("res://Objects/Enemies/enemy_small.tscn")
const enemyBigPath = preload("res://Objects/Enemies/big_enemy.tscn")

func spawn_enemy_small():
	var enemy_small = enemySmallPath.instantiate()
	add_child(enemy_small)
	var distance_from_tank = randf_range(500.0, 1000.0)
	
	#allows for spawning enemies behind the player (disabled right now)
	#var negative_multiplier = rng.randi_range(-1,0)
	#if negative_multiplier == 0:
	#	negative_multiplier = 1
	var negative_multiplier = 1
	
	var enemy_small_spawn_position = GameManager.tank_position.x + distance_from_tank*negative_multiplier
	if enemy_small_spawn_position < 120:
		enemy_small_spawn_position = 120
		if GameManager.tank_position.x < 616:
			enemy_small_spawn_position = GameManager.tank_position.x + distance_from_tank
	#print("Spawned enemy at " + str(enemy_small_spawn_position))
	enemy_small.position.x = enemy_small_spawn_position
	enemy_small.position.y = GameManager.tank_position.y - 5
	
func spawn_enemy_big():
	var enemy_big = enemyBigPath.instantiate()
	add_child(enemy_big)
	var distance_from_tank = 1500.0
	
	#allows for spawning enemies behind the player (disabled right now)
	#var negative_multiplier = rng.randi_range(-1,0)
	#if negative_multiplier == 0:
	#	negative_multiplier = 1
	var negative_multiplier = 1
	
	var enemy_big_spawn_position = GameManager.tank_position.x + distance_from_tank*negative_multiplier
	if enemy_big_spawn_position < 120:
		enemy_big_spawn_position = 120
		if GameManager.tank_position.x < 616:
			enemy_big_spawn_position = GameManager.tank_position.x + distance_from_tank
	#print("Spawned big enemy at " + str(enemy_big_spawn_position))
	enemy_big.position.x = enemy_big_spawn_position
	enemy_big.position.y = GameManager.tank_position.y - 5


func _on_big_enemy_spawner_timeout():
	$"../Timers/enemy_spawn_timer".wait_time = randf_range(1.0, 10.0)
	spawn_enemy_big()

func _on_enemy_spawn_timer_timeout():
	spawn_enemy_small()
