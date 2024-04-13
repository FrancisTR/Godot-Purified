extends StaticBody2D

signal open_leave_menu

func _on_interaction_detection_body_entered(body):
	if (body.name == "CharacterBody2D"):
		emit_signal("open_leave_menu")
