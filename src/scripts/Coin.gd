extends Area2D

func _ready():
	$AnimatedSprite.play("idle")

func _on_Coin_body_entered(body):
	if body.name == "Char":
		$Sound.play()
		queue_free()
