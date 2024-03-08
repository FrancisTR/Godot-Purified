extends Area2D

@onready var dialogue_box = $DialogueBox


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print(true)
		if (GameData.twigItem == 1):
			dialogue_box.start_id = "NPC2"
		if not dialogue_box.running:
			dialogue_box.start()


func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		print("Player has left the tree stump")
		if dialogue_box.running:
			dialogue_box.stop()
