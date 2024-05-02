extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	#TextTransition.set_to_chained_timed(
			#[
				#"",
				#"Sandboa Team",
				#""
			#],
			#"res://Main Menu Scene/MainMenu.tscn",
			#1,
			#""
		#)
	TextTransition.set_to_timed(
		"",
		"res://Main Menu Scene/intro_logo.tscn",
		0.5
	)
	SceneTransition.change_scene("res://Globals/text_transition.tscn")
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
