extends CanvasLayer

@onready var line_edit = get_node("TextureRect/LineEdit")

## Called when the node enters the scene tree for the first time.
func _ready():
	#line_edit.grab_focus()
	$BackButton.grab_focus()
	
	if GameData.username != "":
		$background.texture = load("res://Assets/UISprites/UI_Flat_Slot_01_Unavailable.png")
	else:
		$background.texture = load("res://Assets/Custom/Terrain/murky_water.png")

func _process(delta):
	
	#TODO: Add theme song based on the day
	if (GameData.username == ""):
		SoundControl.is_playing_theme("afternoon")
	elif GameData.day <= 2:
		SoundControl.is_playing_theme("afternoon")
	elif GameData.day >= 3:
		SoundControl.is_playing_theme("main")
	
	
	if Input.is_action_just_pressed("Back") && get_tree().current_scene == self:
		_leave_options_menu()

func _on_back_button_pressed():
	SoundControl.is_playing_sound("button")
	_leave_options_menu()
		
func _leave_options_menu():
	if GameData.username != "":
		Utils.return_to_current_scene()
	else:
		SceneTransition.change_scene("res://Main Menu Scene/MainMenu.tscn")
	GameData.current_ui = ""

# Related script: VolumeOptions.gd


func _on_left_map_button_pressed():
	pass # Replace with function body.
