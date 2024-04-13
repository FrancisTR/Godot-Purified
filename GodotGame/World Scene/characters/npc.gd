extends Area2D

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox

#For Barry
@onready var BarryDestination = $NPCActions/BarryDestination/Marker2D.global_position
var moving_speed = 200
var moving = false


var enterBody = false

var NPCname = null
var PressForDialogue_was_opened = false

var exclamation = load("res://Assets/Custom/UI_Exclamation_Mark_Plate.png")
var question = load("res://Assets/Custom/UI_Question_Mark_Plate.png")

func _ready():
	NPCname = null
	set_process_input(true)
	$PressForDialogue.text = InputMap.action_get_events("StartDialogue")[0].as_text()
	
func go_pos(delta):
	if moving:
		$"../Bargin".global_position = $"../Bargin".global_position.move_toward(BarryDestination, delta*moving_speed)
		$"../Bargin/FixedDialoguePosition/Voice".visible = false
		#Hide all character img
		$"../Bargin/FixedDialoguePosition/CharacterIMG".visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		
	if $"../Bargin".global_position == BarryDestination:
		moving = false
		$"../Bargin".position = Vector2(999999999, 999999999)
		GameData.charLock = false
		GameData.barryDespawned = true


# TODO: Map more ID's for dialogue for more days
func _process(delta):
	
	#Barry gone if he was gone before. This is for Day 3 only
	if (GameData.barryDespawned == true):
		$"../Bargin".position = Vector2(999999999, 999999999)
	

	#Appear the game username in dialogue (Only Appears in NPC interaction)
	Utils.character_list.characters[0].name = GameData.username
	if dialogue_box.running:
		if ($FixedDialoguePosition/DialogueBox.speaker.text == GameData.username):
			$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[0].image

	#Set the variables of the people that already talked to
	#This prevents a reset if the player visited the wilderness and comes back
	dialogue_box.variables["QMain"] = GameData.QMain
	dialogue_box.variables["Profit?"] = GameData.madeProfit
	for i in range(len(GameData.villagersTalked)):
		dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]
	
	
	#Items updating
	#TODO: Add more if needed
	dialogue_box.variables["Twigs"] = GameData.itemDialogue[0]["Value"]
	dialogue_box.variables["Rocks"] = GameData.itemDialogue[1]["Value"]
	dialogue_box.variables["WaterBottle"] = GameData.itemDialogue[2]["Value"]
	dialogue_box.variables["TinCans"] = GameData.itemDialogue[3]["Value"]
	
	#TODO: Get the day for the appropriate dialogue
	if GameData.day == 1:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan"
	elif GameData.day == 2:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial2"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger2"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin2"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress2"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept2"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak2"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan2"
	elif GameData.day == 3:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial3"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger3"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin3"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress3"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept3"
		elif NPCname == "Croak":
			dialogue_box.start_id = "Croak3"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan3"
	if moving:
		GameData.charLock = true
		go_pos(delta) #For barry
	
	
	if Input.is_action_just_pressed("StartDialogue") and enterBody == true:
		if GameData.current_ui != "dialogue" && GameData.current_ui != "":
			return
		if not dialogue_box.running:
			GameData.charLock = true
			GameData.current_ui = "dialogue"
			$PressForDialogue.visible = false
			
			#Run the loop and check true that we talked to that villager
			# This is for the requirement to leave the Day
			dialogue_box.variables[NPCname] = true
			
			#GameData.QWild = dialogue_box.variables["QWild"]
			
			print(dialogue_box.variables)
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
			
			$FixedDialoguePosition/AnimationPlayer.play("Dialogue_popup")
			dialogue_box.start()
			
			$FixedDialoguePosition/DialogueOpacity.visible = true
			print(dialogue_box)
	elif not dialogue_box.running and enterBody == true:
		GameData.charLock = false
		if GameData.current_ui == "dialogue":
			GameData.current_ui = ""
			$FixedDialoguePosition/DialogueOpacity.visible = false
			$FixedDialoguePosition/CharacterIMG.texture = null
			$FixedDialoguePosition/Voice.visible = false
			$PressForDialogue.visible = true
			
func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		$PressForDialogue.visible = true
		enterBody = true
		NPCname = self.name
	else:
		NPCname = null
		dialogue_box.start_id = ""


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

func show_notif(type):
	if type == "question":
		$Notif.texture = question
	else:
		$Notif.texture = exclamation
	$Notif.show()

func hide_notif():
	$Notif.hide()

func _on_dialogue_box_dialogue_ended():
	
	#Quest stuff for the Main World
	if (dialogue_box.variables["QMain"] == true and GameData.QVillager == ""):
		GameData.QMain = true
		GameData.QVillager = NPCname
	if (dialogue_box.variables["Profit?"] == true):
		GameData.madeProfit = true
	pass # Replace with function body.
	
	
func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO: Stop the voice recording if node proceeds
	
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
	if value == "BarryRun":
		moving = true
		
		
	if value == "MainComplete":
		GameData.questComplete["Main"] = true
		#Remove the items since we gave them
		#TODO: Add more days
		if GameData.NPCgiveNoMore == false:
			if GameData.day == 1:
				Utils.remove_from_inventory("Twig", 6)
			elif GameData.day == 2:
				Utils.remove_from_inventory("WaterBottle", 1)
			elif GameData.day == 3:
				Utils.remove_from_inventory("TinCan", 3)
			GameData.NPCgiveNoMore = true


func _on_animation_player_animation_finished(anim_name):
	#TODO: back to true for final
	$FixedDialoguePosition/Voice.visible = false


func _on_voice_pressed():
	print("Play Voice Recording")
