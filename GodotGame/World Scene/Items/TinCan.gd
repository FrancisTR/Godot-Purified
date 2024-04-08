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
		SoundControl.is_playing_sound("pickup")
		print("Player has picked up a Pot")
		PickedUp.emit()
		
		#Before removal, we get its position and notify the master item
		#that it has been "Taken", which is set true.
		#This prevents from spawning again. This is used in Wilderness.gd
		GameData.get_item_posX = $".".position.x
		GameData.get_item_posY = $".".position.y
		
		# Twig for dialogue
		GameData.itemDialogue[3]["Value"] = GameData.itemDialogue[3]["Value"] + 1
		
		queue_free()
		Utils.add_to_inventory("TinCan", 1)
		getTexture()
			
func getTexture():
	return $TinSprite.sprite_frames.get_frame_texture("default", 0)
