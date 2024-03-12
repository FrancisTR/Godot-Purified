extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")

# Called when the node enters the scene tree for the first time.
func _ready():
	line_edit.grab_focus()

func _on_button_pressed():
	print(line_edit.text)
	GameData.username = line_edit.text
	get_tree().change_scene_to_file("res://World Scene/World.tscn")


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Main Menu Scene/MainMenu.tscn")
