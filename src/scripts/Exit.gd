extends Area2D

export(String, FILE, "*.tscn") var next_scene

onready var character = get_tree().get_root().get_child(0).get_node("Char")

func _process(_delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.get_name() == "Char":
			yield( character, "landing_finished")
			get_tree().change_scene( next_scene)
