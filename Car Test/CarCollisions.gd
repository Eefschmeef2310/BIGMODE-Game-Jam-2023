extends Area2D

func hit():
	CarGlobals.carHealth -= 10;
	if(CarGlobals.carHealth <= 0):
		print('You lose!')
		Engine.time_scale = 0.0
