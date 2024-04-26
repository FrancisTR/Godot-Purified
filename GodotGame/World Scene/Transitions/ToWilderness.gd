extends StaticBody2D

func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		SceneTransition.change_scene("res://World Scene/Wilderness.tscn")
