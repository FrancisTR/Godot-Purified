extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")

## Called when the node enters the scene tree for the first time.
func _ready():
	#line_edit.grab_focus()
	$BackButton.grab_focus()
	if GameData.username:
		$background.texture = load("res://Assets/UISprites/UI_Flat_Slot_01_Unavailable.png")
	else:
		$background.texture = load("res://Assets/Custom/Terrain/murky_water.png")


func _on_back_button_pressed():
	SoundControl.is_playing_sound("button")
	if GameData.username:
		get_tree().change_scene_to_file("res://World Scene/World.tscn")
	else:
		get_tree().change_scene_to_file("res://Main Menu Scene/MainMenu.tscn")
	


# Related script: VolumeOptions.gd


func _on_left_map_button_pressed():
	pass # Replace with function body.
