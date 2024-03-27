extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Error.text = "Error: You must enter a valid name."
	line_edit.grab_focus()

func _on_button_pressed():
	print(line_edit.text)
	line_edit.text = line_edit.text.strip_edges(true, true)
	
	if line_edit.text == "":
		$Error.visible = true
	else:
		GameData.username = line_edit.text
		if (GameData.visitTutorial == false): #Continue the tutorial
			get_tree().change_scene_to_file("res://Main Menu Scene/tutorial.tscn")
		else:
			get_tree().change_scene_to_file("res://World Scene/World.tscn")



func _on_line_edit_text_changed(new_text):
	$Error.visible = false
