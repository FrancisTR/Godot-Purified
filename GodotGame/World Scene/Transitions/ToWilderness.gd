extends StaticBody2D

func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		if GameData.day != 7:
			SceneTransition.change_scene("res://World Scene/Wilderness.tscn")
		else:
			print("No no no")
