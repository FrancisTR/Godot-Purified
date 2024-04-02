extends Area2D

@onready var dialogue_box = $DialogueBox
@export var questReceived = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		SoundControl.is_playing_sound("pickup")
		print("Player has entered the tree stump")
		if not dialogue_box.running:
			dialogue_box.start()
			

func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		print("Player has left the tree stump")
		if dialogue_box.running:
			dialogue_box.stop()
