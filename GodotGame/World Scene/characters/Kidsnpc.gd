extends Area2D

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox


var enterBody = false

var NPCname = null

var PressForDialogue_was_opened = false


func _ready():
	NPCname = null
	set_process_input(true)
	$PressForDialogue.text = RemapperData.get_keymap_name("Interaction")
	if (GameData.day == 3):
		$Sprite2D.animation = "Day3Sad"


# TODO: Map more ID's for dialogue for more days
func _process(delta):
	
	#Appear the game username in dialogue (Only Appears in NPC interaction)
	Utils.character_list.characters[0].name = GameData.username
	if (dialogue_box.running):
		if ($FixedDialoguePosition/DialogueBox.speaker.text == GameData.username):
			$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[0].image
			
			
	#Set the variables of the people that already talked to
	#This prevents a reset if the player visited the wilderness and comes back
	dialogue_box.variables["QWild"] = GameData.QWild
	#dialogue_box.variables["Profit?"] = GameData.madeProfit
	#for i in range(len(GameData.villagersTalked)):
		#dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]



	# Who is the player talking?
	#TODO: Add more Dialogue
	if GameData.day == 1:
		dialogue_box.start_id = "Children"
		if GameData.inventory_amount.keys().find("WaterBottleSpecial") != -1: #Quest Complete
			dialogue_box.start_id = "ChildrenComplete"
	
	elif GameData.day == 2:
		dialogue_box.start_id = "Children2"
		if GameData.inventory_amount.keys().find("BoilingPot") != -1: #Quest Complete
			dialogue_box.start_id = "ChildrenComplete2"
	
	elif GameData.day == 3:
		dialogue_box.start_id = "Children3"
		if GameData.inventory_amount.keys().find("WaterFilter") != -1: #Quest Complete
			dialogue_box.start_id = "ChildrenComplete3"
	
	
	if (Input.is_action_just_pressed("Interaction") and enterBody == true):
		if GameData.current_ui != "dialogue" && GameData.current_ui != "":
			return
		if not dialogue_box.running:
			GameData.QWild = true
			GameData.charLock = true
			GameData.current_ui = "dialogue"
			$PressForDialogue.visible = false
			
			#GameData.QWild = dialogue_box.variables["QWild"]
			
			print(dialogue_box.variables)
			
			$FixedDialoguePosition/AnimationPlayer.play("Dialogue_popup")
			dialogue_box.start()
			$FixedDialoguePosition/CharacterIMG.visible = true
			$FixedDialoguePosition/DialogueOpacity.visible = true
			print(dialogue_box)
	elif not dialogue_box.running and enterBody == true:
		GameData.charLock = false
		if GameData.current_ui == "dialogue":
			GameData.current_ui = ""
			$FixedDialoguePosition/DialogueOpacity.visible = false
			$FixedDialoguePosition/CharacterIMG.texture = null
			$FixedDialoguePosition/Voice.visible = false
			$FixedDialoguePosition/CharacterIMG.visible = false
			$PressForDialogue.visible = true


#Not used
func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		$PressForDialogue.visible = true
		enterBody = true
		NPCname = self.name
	else:
		NPCname = null
		dialogue_box.start_id = ""




#Not used
func _on_body_exited(body):
	if (body.name == "CharacterBody2D"):
		print("Player has left")
		enterBody = false
		$PressForDialogue.visible = false
		GameData.current_ui = ""
		NPCname = null
		if dialogue_box.running:
			GameData.charLock = false
			dialogue_box.stop()
		dialogue_box.start_id = ""
		
		
		
		
		
func show_map_icon():
	$MapIcon.show()
	$Sprite2D.hide()
	if $PressForDialogue.visible:
		$PressForDialogue.hide()
		PressForDialogue_was_opened = true
		
	
func hide_map_icon():
	$Sprite2D.show()
	$MapIcon.hide()
	if PressForDialogue_was_opened:
		$PressForDialogue.show()
		PressForDialogue_was_opened = false




func _on_dialogue_box_dialogue_ended():
	$FixedDialoguePosition/CharacterIMG.visible = false
	#Quest stuff for the Main World
	if (dialogue_box.variables["QWild"] == true):
		GameData.QWild = true
	#if (dialogue_box.variables["Profit?"] == true):
		#GameData.madeProfit = true
	
	
func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	SoundControl.is_playing_sound("button")
	
	#TODO Fix cases where the username is the same as the NPCs
	if $FixedDialoguePosition/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($FixedDialoguePosition/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($FixedDialoguePosition/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
		$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image



func _on_dialogue_box_dialogue_signal(value):
	if value == "WildComplete":
		GameData.questComplete["Wild"] = true


func _on_animation_player_animation_finished(anim_name):
	$FixedDialoguePosition/Voice.visible = true

func _on_voice_pressed():
	print("Play Voice Recording")
