extends KinematicBody2D

const MAX_SPEED = 80
const ACCELERATION = 10

var motion = Vector2.ZERO
var direction = false

func _physics_process(delta):
	
	if direction:
		motion.y = min(motion.y + ACCELERATION, MAX_SPEED)
		print(1)
	else:
		motion.y = max(motion.y - ACCELERATION, -MAX_SPEED)
		print(2)
		
	if position.y <= 0 or position.y >= 140:
		if direction :
			motion.y = -30
		else:
			motion.y = 30
		$AnimatedSprite.flip_v = direction
		#$AnimatedSprite.play("run")
		direction = !direction
		
	motion = move_and_slide(motion)


func _on_PlayerDetector_body_entered(body):
	if body.name == "Char":
		#$Music.play()
		get_tree().reload_current_scene()
