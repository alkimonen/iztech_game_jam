extends Area2D

export(int) var activation_time

onready var character = get_tree().get_root().get_child(0).get_node("Char")

var active = true

func _ready():
	$Timer.set_wait_time( activation_time)
	$Timer.start()

func _on_Timer_timeout():
	if active:
		$AnimatedSprite.play("turnoff")
		$CollisionShape2D.set_disabled( true)
		active = false
	else:
		$AnimatedSprite.play("turnon")
		
		$CollisionShape2D.set_disabled( false)
		active = true


func _on_Laser_body_entered(body):
	if body.get_name() == "Char":
		if character != null:
			character._die()
		$Laser.play()


func _on_AnimatedSprite_animation_finished():
	if( $AnimatedSprite.get_animation() == "turnon"):
		$AnimatedSprite.play("default")


func _on_Die_finished():
	get_tree().reload_current_scene()


func _on_Laser_finished():
	$Die.play()
