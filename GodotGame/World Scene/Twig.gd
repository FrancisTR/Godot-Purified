extends Area2D

signal PickedUp

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		print("Player has picked up a twig")
		#$TwigSprite.hide()
		PickedUp.emit()
		queue_free()
		Utils.add_to_inventory("Twig", 1)
			
