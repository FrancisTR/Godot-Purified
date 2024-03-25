extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")

## Called when the node enters the scene tree for the first time.
#func _ready():
	#line_edit.grab_focus()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Main Menu Scene/MainMenu.tscn")


# Related script: VolumeOptions.gd


func _on_left_map_button_pressed():
	pass # Replace with function body.
