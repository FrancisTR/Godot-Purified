extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")
var profanityWord = false

# Called when the node enters the scene tree for the first time.
func _ready():
	line_edit.grab_focus()

func _process(delta):
	SoundControl.is_playing_theme("afternoon")

func _on_button_pressed():
	print(line_edit.text)
	SoundControl.is_playing_sound("button")
	line_edit.text = line_edit.text.strip_edges(true, true)
	
	
	
	#Check to see if the name is empty and if it is a bad word
	var file = FileAccess.open("res://Main Menu Scene/Menu_Scripts/en.txt", FileAccess.READ)
	
	var index = 1
	while not file.eof_reached(): # iterate through all lines until the end of file is reached
		var forbidenName = file.get_line()


		if line_edit.text == forbidenName:
			$Error.text = "Error: You can't use that name."
			$Error.visible = true
			profanityWord = true
		index += 1
	
	
	
	if profanityWord == false:
		if line_edit.text == "":
			$Error.text = "Error: You must enter a valid name."
			$Error.visible = true
		else:
			GameData.username = line_edit.text
			if (GameData.visitTutorial == false): #Continue the tutorial
				SceneTransition.change_scene("res://Main Menu Scene/tutorial.tscn")
			else:
				SceneTransition.change_scene("res://World Scene/World.tscn")



func _on_line_edit_text_changed(new_text):
	SoundControl.is_playing_sound("dialogue")
	$Error.visible = false
