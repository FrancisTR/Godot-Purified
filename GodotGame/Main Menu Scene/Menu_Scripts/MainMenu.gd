extends Control # Originally Node2D; probably will conflict


## Called when the node enters the scene tree for the first time.
#func _ready():
	#$StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	get_tree().quit()


func _on_start_button_pressed():
	# If first time, go to tutorial
	if (GameData.visitTutorial == false):
		get_tree().change_scene_to_file("res://Main Menu Scene/tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://Main Menu Scene/EnterName.tscn")


func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://Main Menu Scene/Options.tscn")
