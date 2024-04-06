extends StaticBody2D

@onready var dialogue_box = $Dialogue/Dialogue/DialogueBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dialogue_box.running:
		GameData.charLock = false
	pass



func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		
		#Show an error dialogue where the player did not craft/find
		if ((GameData.inventory_amount.keys().find("WaterBottle") == -1) and GameData.day == 1):
			dialogue_box.start("Error")
			GameData.charLock = true
		elif ((GameData.inventory_amount.keys().find("BoilingPot") == -1) and GameData.day == 2):
			dialogue_box.start("Error")
			GameData.charLock = true
		elif ((GameData.inventory_amount.keys().find("WaterFilter") == -1) and GameData.day == 3):
			dialogue_box.start("Error")
			GameData.charLock = true
		else:
			#All requirements met
			GameData.questComplete["Wild"] = true
			SceneTransition.change_scene("res://World Scene/World.tscn")
	pass # Replace with function body.


func _on_dialogue_box_dialogue_proceeded(node_type):
	SoundControl.is_playing_sound("button")
	pass # Replace with function body.
