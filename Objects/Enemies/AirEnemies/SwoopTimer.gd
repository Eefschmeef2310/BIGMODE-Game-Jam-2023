extends Timer

var initialY
var targetY
var tween

var time = 1

func _on_timeout():
	initialY = $"..".position.y
	targetY = GameManager.tank_position.y - 10
	tween = create_tween()

	tween.tween_property($"..", "position:y", targetY, time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($"..", "position:y", initialY, time).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.tween_callback(restart)
	
func restart():
	start()
