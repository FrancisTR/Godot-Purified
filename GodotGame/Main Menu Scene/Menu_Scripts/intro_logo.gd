extends Control


func _ready():
	$Timer.start()


func _on_timeout():
	TextTransition.set_to_timed(
		"",
		"res://Main Menu Scene/MainMenu.tscn",
		1.2
	)
	SceneTransition.change_scene("res://Globals/text_transition.tscn")
