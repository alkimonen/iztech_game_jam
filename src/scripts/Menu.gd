extends Control

export(String, FILE, "*.tscn") var start_scene
export(String, FILE, "*.tscn") var about_scene

func _on_StartButton_pressed():
	get_tree().change_scene(start_scene)


func _on_AboutButton_pressed():
	get_tree().change_scene(about_scene)
