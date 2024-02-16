extends Area2D

@onready var dialogue_box = $DialogueBox


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print(true)
		if not dialogue_box.running:
			dialogue_box.start()
