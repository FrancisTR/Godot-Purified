extends StaticBody2D

@onready var dialogue_box = $Dialogue/Dialogue/DialogueBox


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dialogue_box.running:
		GameData.charLock = false
	else:
		$Dialogue/Dialogue/CharacterIMG.visible = true
		#TODO: Switch to true for final
		$Dialogue/Dialogue/Voice.visible = false
	
		



func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		GameData.charLock = true
		#TODO Add more days
		#Show an error dialogue where the player did not craft/find
		if GameData.day >= 4:
			SceneTransition.change_scene("res://World Scene/World.tscn")
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 1):
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				dialogue_box.start("Error")
			#dialogue_box.start("Kids")
			#GameData.charLock = true
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 2):
			#dialogue_box.start("Kids2")
			#GameData.charLock = true
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				dialogue_box.start("Error")
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 3):
			#dialogue_box.start("Kids3")
			#GameData.charLock = true
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				dialogue_box.start("Error")
		else:
			#All requirements met
			#TODO: Add more days
			if GameData.questComplete["Wild"] == true and GameData.leaveVillageQuest == false:
				if (GameData.day == 1):
					dialogue_box.start("ChildrenComplete")
				elif (GameData.day == 2):
					dialogue_box.start("ChildrenComplete2")
				elif (GameData.day == 3):
					dialogue_box.start("ChildrenComplete3")
			else:
				SceneTransition.change_scene("res://World Scene/World.tscn")


func _on_dialogue_box_dialogue_proceeded(node_type):
	SoundControl.is_playing_sound("button")
	
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO Stop audio once we continue
	#TODO Fix cases where the username is the same as the NPCs
	if $Dialogue/Dialogue/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($Dialogue/Dialogue/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($Dialogue/Dialogue/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
		$Dialogue/Dialogue/CharacterIMG.texture = Utils.character_list.characters[idx].image



func _on_voice_pressed():
	print("Play Audio")


func _on_dialogue_box_dialogue_ended():
	$Dialogue/Dialogue/Voice.visible = false
	$Dialogue/Dialogue/CharacterIMG.visible = false


func _on_dialogue_box_dialogue_signal(value):
	if value == "Leave":
		GameData.leaveVillageQuest = true
		SceneTransition.change_scene("res://World Scene/World.tscn")
