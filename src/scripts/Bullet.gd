extends Area2D

export(int) var speed
var direction = -1

"""
Direction
-1 for down
1 for up
"""

func _physics_process(delta):
	position += transform.x * speed * delta * direction


func _on_Bullet_body_entered(body):
	if body.name == "Char":
		$Hit.play()
		get_tree().reload_current_scene()
	else:
		queue_free()

