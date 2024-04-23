extends Area2D
signal leave_village

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox

#For Barry
@onready var BarryDestination = $NPCActions/BarryDestination/Marker2D.global_position
#For player on Day 7
@onready var PlayerDestination = $"../../Other/CharacterBody2D/Marker2D".global_position
var specialLockDay7 = false #Only use this for Old man only
var idxMovement = 0 #Use for movement on Day 7 Character

var moving_speed = 200
var moving = false


var enterBody = false

var NPCname = null
var PressForDialogue_was_opened = false
var playerRuns = false

var exclamation = load("res://Assets/Custom/UI_Exclamation_Mark_Plate.png")
var question = load("res://Assets/Custom/UI_Question_Mark_Plate.png")

func _ready():
	NPCname = null
	set_process_input(true)
	$PressForDialogue.text = InputMap.action_get_events("StartDialogue")[0].as_text()
	
	
func go_pos(delta):
	if moving and playerRuns == false: #Barry
		$"../Bargin".global_position = $"../Bargin".global_position.move_toward(BarryDestination, delta*moving_speed)
		$"../Bargin/FixedDialoguePosition/Voice".visible = false
		#Hide all character img
		$"../Bargin/FixedDialoguePosition/CharacterIMG".visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$"../Bargin/StaticBody2D/CollisionShape2D".disabled = true
		$"../Bargin/Sprite2D".animation = "Barry_Running"
	elif moving and playerRuns == true: #Player
		$"../../Other/CharacterBody2D".global_position = $"../../Other/CharacterBody2D".global_position.move_toward(PlayerDestination, delta*moving_speed)
		$"../OldMan/FixedDialoguePosition/Voice".visible = false
		#Hide all character img (TODO Depends on who ends the call)
		$"../OldMan/FixedDialoguePosition/DialogueOpacity".visible = false
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$"../../Other/CharacterBody2D/CollisionShape2D".disabled = true
		
		if (idxMovement == 0):
			$"../../Other/CharacterBody2D/Sprite2D".animation = "Right"
		else:
			$"../../Other/CharacterBody2D/Sprite2D".animation = "Down"
	
	
	if $"../Bargin".global_position == BarryDestination and playerRuns == false:
		moving = false
		$"../Bargin".position = Vector2(999999999, 999999999)
		GameData.charLock = false
		GameData.barryDespawned = true
	
	#If we reach the destination, move on to the next day
	#TODO Reset must be consistent with the leave village UI
	if $"../../Other/CharacterBody2D".global_position == PlayerDestination and playerRuns == true:
		print("Done")
		#Move to the second Marker
		idxMovement = 1
		PlayerDestination = $"../../Other/CharacterBody2D/Marker2D2".global_position
		$"../../Other/CharacterBody2D".global_position = $"../../Other/CharacterBody2D".global_position.move_toward($"../../Other/CharacterBody2D/Marker2D2".global_position, delta*moving_speed)
		
		
		emit_signal("leave_village")
		GameData.QVillager = ""
		#GameData.charLock = false
		if GameData.inventory_amount.keys().find("Twig") != -1:
			Utils.remove_from_inventory("Twig", int(GameData.inventory_amount["Twig"]))
		
		if GameData.inventory_amount.keys().find("Rock") != -1:
			Utils.remove_from_inventory("Rock", int(GameData.inventory_amount["Rock"]))
		
		if GameData.inventory_amount.keys().find("Sand") != -1:
			Utils.remove_from_inventory("Sand", int(GameData.inventory_amount["Sand"]))
		
		if GameData.inventory_amount.keys().find("Moss") != -1:
			Utils.remove_from_inventory("Moss", int(GameData.inventory_amount["Moss"]))
		
		if GameData.inventory_amount.keys().find("TinCan") != -1:
			Utils.remove_from_inventory("TinCan", int(GameData.inventory_amount["TinCan"]))
		
		if GameData.inventory_amount.keys().find("WaterBottle") != -1:
			Utils.remove_from_inventory("WaterBottle", int(GameData.inventory_amount["WaterBottle"]))
		
		
		#Reset villagers talked
		for i in range(len(GameData.villagersTalked)):
			GameData.villagersTalked[i]["Talked"] = false

		GameData.QMain = {}
		GameData.QWild = false
		GameData.questComplete = {"Main": false, "Wild": false}
		GameData.NPCgiveNoMore = false
		
		#TODO: Add more when needed
		GameData.itemDialogue[0]["Value"] = 0
		GameData.itemDialogue[1]["Value"] = 0
		GameData.itemDialogue[2]["Value"] = 0
		GameData.itemDialogue[3]["Value"] = 0
			
		#Reset take items and spawn again on the next day
		GameData.get_item_posX = null
		GameData.get_item_posY = null
		for i in range(len(GameData.itemSpawns)):
			GameData.itemSpawns[i]["Taken"] = false
		
		
		
		GameData.visitedWilderness == false
		
		GameData.madeProfit = false
		GameData.barryDespawned = false
		GameData.talkToKid = false
		GameData.leaveVillageQuest = false
		
		
		
		#TO Day 8 we go
		SoundControl.stop_playing()

		TextTransition.set_to_click(
			"You leave the village and come back the next day",
			"res://World Scene/World.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
		if (GameData.day != 8): #Prevent the loop
			increase_day(1)
		
func increase_day(amount):
	if(GameData.day+amount > 0):
		GameData.day += amount	
		
		
		
		
		
		
		


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


	#TODO: If all the requests has been listed, we then save the Qmain
	if GameData.QMain.values().size() >= 1:
		#Note that multiple requests is handled by the dialogue itself
		dialogue_box.variables["QMain"] = true
	
	
	dialogue_box.variables["Profit?"] = GameData.madeProfit
	dialogue_box.variables["Discount"] = GameData.Discount
	for i in range(len(GameData.villagersTalked)):
		dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]
	
	
	#Items updating
	#TODO: Add more if needed
	dialogue_box.variables["Twigs"] = GameData.itemDialogue[0]["Value"]
	dialogue_box.variables["Rocks"] = GameData.itemDialogue[1]["Value"]
	dialogue_box.variables["WaterBottle"] = GameData.itemDialogue[2]["Value"]
	dialogue_box.variables["TinCans"] = GameData.itemDialogue[3]["Value"]
	
	#TODO: Get the day for the appropriate dialogue
	if GameData.visitTutorial == true:
		dialogue_box.start_id = "TaliaTutorial"
	elif GameData.day == 1:
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
	elif GameData.day == 4:
		# Who is the player talking to?
		if NPCname == "Denial" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Denial4"
		elif NPCname == "Anger" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Anger4"
		elif NPCname == "Bargin" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Bargin4"
		elif NPCname == "Depress" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Depress4"
		elif NPCname == "Accept" and dialogue_box.variables["OldMan"] == true:
			dialogue_box.start_id = "Accept4"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan4"
		else:
			dialogue_box.start_id = "Day4"
	elif GameData.day == 5:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial5"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger5"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin5"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress5"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept5"
		elif NPCname == "OldMan":
			var count = 0
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Talked"] == true:
					count = count + 1
			#We can talk to the old man if everyone has been talked to
			print(count)
			if count >= 5 and GameData.villagersTalked[6]["Talked"] == false:
				dialogue_box.start_id = "OldMan5"
			else:
				dialogue_box.start_id = "Day5OldMan"
	elif GameData.day == 6:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Denial6"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Anger6"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Bargin6"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Depress6"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Accept6"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan6"
	elif GameData.day == 7:
		# Who is the player talking to?
		if NPCname == "Denial":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Anger":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Bargin":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Depress":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "Accept":
			dialogue_box.start_id = "Day7Negate"
		elif NPCname == "OldMan":
			dialogue_box.start_id = "OldMan7"
			
			
		
	if moving:
		GameData.charLock = true
		go_pos(delta) #For barry
	
	
	if Input.is_action_just_pressed("StartDialogue") and enterBody == true and specialLockDay7 == false:
		#Focus the button that is visible on dialogue
		#for option in dialogue_box.options.get_children():
			#if option.visible:
				#print(true)
				#option.grab_focus()
				
		if GameData.current_ui != "dialogue" && GameData.current_ui != "":
			return
		if not dialogue_box.running:
			GameData.charLock = true
			GameData.current_ui = "dialogue"
			$PressForDialogue.visible = false
			$FixedDialoguePosition/CharacterIMG.visible = true
			
			#TODO
			#Run the loop and check true that we talked to that villager
			# This is for the requirement to leave the Day
			#Note that for Croak, you must talk to Barry.
			if GameData.day == 1 and GameData.visitTutorial == false:
				if NPCname == "Croak" and GameData.villagersTalked[2]["Talked"] == true:
					dialogue_box.variables[NPCname] = true
					print(dialogue_box.variables)
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
				
				elif NPCname != "Croak":
					dialogue_box.variables[NPCname] = true
					print(dialogue_box.variables)
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
			elif GameData.day == 4:
				#Talk to the old man first
				if (dialogue_box.variables["OldMan"] == true or NPCname == "OldMan"):
					dialogue_box.variables[NPCname] = true
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
			
			
			elif GameData.day == 5:
				var counts = 0
				for i in range(len(GameData.villagersTalked)):
					if GameData.villagersTalked[i]["Talked"] == true:
						counts = counts + 1
				#We can talk to the old man if everyone has been talked to
				#Talk to the old man first
				if (GameData.villagersTalked[6]["Talked"] == false and counts == 5):
					dialogue_box.variables[NPCname] = true
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
				elif (NPCname != "OldMan" and (GameData.villagersTalked[0]["Talked"] == false or GameData.villagersTalked[1]["Talked"] == false or GameData.villagersTalked[2]["Talked"] == false or GameData.villagersTalked[4]["Talked"] == false or GameData.villagersTalked[5]["Talked"] == false)):
					dialogue_box.variables[NPCname] = true
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
			elif GameData.day == 7:
				#Talk to the old man only
				if (NPCname == "OldMan"):
					dialogue_box.variables[NPCname] = true
					for i in range(len(GameData.villagersTalked)):
						if GameData.villagersTalked[i]["Name"] == NPCname:
							GameData.villagersTalked[i]["Talked"] = true
			
			else:
				print(NPCname)
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
	elif (not dialogue_box.running and enterBody == true):
		#or (not dialogue_box.running and dialogue_box.variables["Discount"] != ""
		GameData.charLock = false
		if GameData.current_ui == "dialogue":
			GameData.current_ui = ""
		$FixedDialoguePosition/DialogueOpacity.visible = false
		$FixedDialoguePosition/CharacterIMG.texture = null
		$FixedDialoguePosition/CharacterIMG.visible = false
		$FixedDialoguePosition/Voice.visible = false
		#$PressForDialogue.visible = true
			
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
	$FixedDialoguePosition/CharacterIMG.visible = false
	#TODO: Quest stuff for the Main World
	if (dialogue_box.variables["QMain"] == true and GameData.QVillager == ""):
		
		if GameData.QMain.keys().find(NPCname) == -1:
			GameData.QMain[NPCname] = false 
		GameData.QVillager = NPCname
	if (dialogue_box.variables["Profit?"] == true):
		GameData.madeProfit = true
	if (dialogue_box.variables["Discount"] != ""):
		GameData.Discount = dialogue_box.variables["Discount"]
	$PressForDialogue.visible = true
	dialogue_box.start_id = ""
	
	#This should be the ONLY case since the old man is the only person you are talking to
	if (NPCname == "OldMan" and GameData.day == 7 and GameData.inventory_amount.size() != 0):
		if (GameData.inventory_amount.keys().find("WaterBottleSpecial") != -1 or GameData.inventory_amount.keys().find("BoilingPot") != -1 or GameData.inventory_amount.keys().find("WaterFilter") != -1):
			print("Activate Union Hanger")
			specialLockDay7 = true
			$PressForDialogue.visible = false
			#Draw the items to display on screen
			#We allow the user to click on the item to learn more
			$NPCActions/OldManInventory/InventoryDialogue.draw_items(GameData.inventory)
			$NPCActions/OldManInventory.visible = true
	elif (NPCname == "OldMan" and GameData.day == 7 and moving == false):
		#Continue with the dialogue
		dialogue_box.start("OldMan7Finish")
		GameData.charLock = true
		GameData.current_ui = "dialogue"
		$PressForDialogue.visible = false
		$FixedDialoguePosition/CharacterIMG.visible = true
	
	
	
func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO: Stop the voice recording if node proceeds
	
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
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
	if value == "PlayerRun":
		moving = true
		playerRuns = true
		
	if value == "MainComplete":
		#GameData.questComplete["Main"] = true
		GameData.QMain[NPCname] = true
		
		var npcComplete = GameData.QMain.values()
		if not npcComplete.has(false):
			#All request has been fufill
			GameData.questComplete["Main"] = true
		
		#Remove the items since we gave them
		#TODO: Add more days
		if GameData.NPCgiveNoMore == false:
			if GameData.day == 1 and GameData.visitTutorial == true:
				Utils.remove_from_inventory("Rock", 1)
			elif GameData.day == 1:
				Utils.remove_from_inventory("Twig", 6)
			elif GameData.day == 2:
				Utils.remove_from_inventory("Rock", 4)
			elif GameData.day == 3:
				Utils.remove_from_inventory("TinCan", 3)
			GameData.NPCgiveNoMore = true
			
	if value == "TutorialEnded":
		TextTransition.set_to_click(
				"You then enter the village, excited for the opportunity to make profit.",
				"res://World Scene/World.tscn",
				"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
		GameData.day = 1

		GameData.inventory = []

		GameData.inventory_amount = {}

		#What is required to go to the next day
		GameData.inventory_requirement = {}

		GameData.charLock = false
		GameData.barryDespawned = false

		GameData.current_ui = ""
		GameData.current_scene = ""
		GameData.save_position = false
		GameData.player_position

		GameData.visitTutorial = false
		GameData.visitedWilderness = false
		GameData.talkToKid = false


		GameData.leaveVillageQuest = false



		#Dialogue related stuff

		GameData.QMain = {}
		GameData.QWild = false
		GameData.QMainLocationIdx = {}
		GameData.madeProfit = false
		GameData.NPCgiveNoMore = false #Give items once and not dup
		#Quest is finished
		GameData.questComplete = {"Main": false, "Wild": false}
		GameData.Discount = ""

		#TODO Add more if needed to stack of the items needed for NPC
		GameData.itemDialogue = [
			{
				"Name": "Twigs",
				"Value": 0
			},
			{
				"Name": "Rocks",
				"Value": 0
			},
			{
				"Name": "WaterBottle",
				"Value": 0
			},
			{
				"Name": "TinCans",
				"Value": 0
			}
		]

		GameData.QVillager = ""

		GameData.villagersIndex = {
			"Accept": 0,
			"Anger": 1,
			"Bargin": 2,
			"Croak": 3,
			"Denial": 4,
			"Depress": 5,
			"OldMan": 6,
				
			"Rano": 7,
			"Ribbit": 8,
			"Hop": 9,
			"Leap": 10,
		}

		GameData.villagersTalked = [
			{
				"Name": "Accept",
				"Talked": false
			},
			{
				"Name": "Anger",
				"Talked": false
			},
			{
				"Name": "Bargin",
				"Talked": false
			},
			{
				"Name": "Croak",
				"Talked": false
			},
			{
				"Name": "Denial",
				"Talked": false
			},
			{
				"Name": "Depress",
				"Talked": false
			},
			{
				"Name": "OldMan",
				"Talked": false
			},
			{
				"Name": "Talia",
				"Talked": false
			},
		]


























func _on_animation_player_animation_finished(anim_name):
	#TODO: back to true for final
	$FixedDialoguePosition/Voice.visible = false
	dialogue_box.show_options()


func _on_voice_pressed():
	print("Play Voice Recording")
