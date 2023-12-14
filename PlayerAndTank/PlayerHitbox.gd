extends Area2D

#TODO So far, this is a single hit kill, and doesn't account for jumping on enemies (if we're going for that) - E
func deal_damage(_damage):
	#health -= damage
	#update_health()
	#
	#if health <= 0:
		#GameManager.game_over = true
	GameManager.game_over = true
