extends StaticBody2D

@onready var dialogue_box = $Dialogue/Dialogue/DialogueBox

func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		GameData.charLock = true
		if GameData.day == 7 and GameData.villagersTalked[6]["Talked"] == false:
			dialogue_box.start("Day7TalktoOldMan")
		else:
			SceneTransition.change_scene("res://World Scene/Wilderness.tscn")



func _on_dialogue_box_dialogue_ended():
	GameData.charLock = false



#TODO Sometime important. The dialogue only pops up on day 7
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
