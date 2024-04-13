extends Area2D

signal PickedUp


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		SoundControl.is_playing_sound("pickup")
		print("Player has picked up a Water Bottle Special")

		PickedUp.emit()
		
		#Before removal, we get its position and notify the master item
		#that it has been "Taken", which is set true.
		#This prevents from spawning again. This is used in Wilderness.gd
		GameData.get_item_posX = $".".position.x
		GameData.get_item_posY = $".".position.y
		
		#Unique if this is picked up on day 1
		#TODO Remove Code for special water bottle
		#if GameData.day == 1 and GameData.talkToKid == true: #First quest
			#GameData.questComplete["Wild"] = true
			#$"../KidsNPC/FixedDialoguePosition/DialogueBox".start("ChildrenComplete")
			#GameData.charLock = true
		GameData.questComplete["Wild"] = true
			
		queue_free()
		Utils.add_to_inventory("WaterBottleSpecial", 1)
		getTexture()
			
func getTexture():
	return $WaterBottleSpecialSprite.sprite_frames.get_frame_texture("default", 0)
