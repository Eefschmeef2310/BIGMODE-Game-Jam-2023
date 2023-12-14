extends RigidBody2D

@export var damage: float = 10

var explosion_active: bool = false
var explosion_radius: int = 400

var relativeScreenCenter: Vector2

#TODO make this animation based - E

func _ready():
	$Area2D/ExplosionHitbox.visible = false
	
func _process(_delta):
	relativeScreenCenter = get_global_transform_with_canvas().origin / get_viewport_rect().size
	relativeScreenCenter.x = (relativeScreenCenter.x - 0.5) * get_viewport_rect().size.aspect() + 0.5
	#Set center of shader to normalized position in screenspace
	($ImpulseShader.material as ShaderMaterial).set_shader_parameter("center", relativeScreenCenter)
	

func _on_explosion_timer_timeout():
	#one timer for settign explosion, second for removal
	#TODO Make this all animation - E
	#if !explosion_active:
		#explosion_active = true
		#$ExplosionTimer.start()
		#$Area2D/ExplosionHitbox.visible = true
		#$Area2D.process_mode = Node.PROCESS_MODE_INHERIT
		#
		#var areas = $Area2D.get_overlapping_areas()
		#for area in areas:
			#print(area.name)
			#if "deal_damage" in area:
				#area.deal_damage(damage)
	#else:
		#queue_free()
	pass

func _on_area_2d_area_entered(area):
	if "deal_damage" in area:
		area.deal_damage(damage)
		
func play_explosion():
	$AnimationPlayer.play("Explosion")
