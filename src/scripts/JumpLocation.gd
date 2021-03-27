extends Node2D

func _ready():
	var character = get_tree().get_root().get_child(0).get_node("Char")
	if character != null:
		print( "added?")
		character.add_new_location( self.position)
	else:
		print( "not found")

