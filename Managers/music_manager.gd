extends Node

var tween : Tween
var transition_speed = 0.5

func play_menu_music():
	stop_game_music()
	$MainStream.play()

func play_game_music():
	$MainStream.stop()
	
	$TankStream.play()
	$TankStream.volume_db = 0
	
	$ManStream.play()
	$ManStream.volume_db = -80
	
	$UpgradeStream.play()
	$UpgradeStream.volume_db = -80

func stop_game_music():
	$TankStream.stop()
	$ManStream.stop()
	$UpgradeStream.stop()

func switch_to_tank():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($TankStream, "volume_db", 0, transition_speed)
	tween.tween_property($ManStream, "volume_db", -80, transition_speed)
	tween.tween_property($UpgradeStream, "volume_db", -80, transition_speed)

func switch_to_man():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($ManStream, "volume_db", 0, transition_speed)
	tween.tween_property($TankStream, "volume_db", -80, transition_speed)
	tween.tween_property($UpgradeStream, "volume_db", -80, transition_speed)

func switch_to_upgrade():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.set_parallel()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($UpgradeStream, "volume_db", 0, transition_speed)
	tween.tween_property($TankStream, "volume_db", -80, transition_speed)
	tween.tween_property($ManStream, "volume_db", -80, transition_speed)
