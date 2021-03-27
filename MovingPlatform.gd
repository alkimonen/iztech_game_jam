extends Node2D

export(int) var direction

export var speed = 3.0

onready var platform = $Platform
onready var tween = $Tween

const idleDuration = 0.5

var move_to = Vector2.LEFT * 144

func _ready():
	if direction < 0:
		move_to = Vector2.LEFT * 144
	else:
		move_to = Vector2.RIGHT * 144
	_init_tween()

func _init_tween():
	var duration = move_to.length() / float(speed * 20)
	tween.interpolate_property(platform, "position", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idleDuration)
	tween.interpolate_property(platform, "position", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, duration + idleDuration * 2)
	tween.start()


func _on_Area2D_body_entered(body):
	if body.name == "Char":
		#$Music.play()
		get_tree().reload_current_scene()
