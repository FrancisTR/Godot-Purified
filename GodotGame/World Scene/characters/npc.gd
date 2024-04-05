extends Area2D

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox

var enterBody = false

var NPCname = null

var PressForDialogue_was_opened = false

func _ready():
	NPCname = null
	set_process_input(true)
	

# TODO: Map more ID's for dialogue for more days
func _process(delta):
	#Set the variables of the people that already talked to
	#This prevents a reset if the player visited the wilderness and comes back
	dialogue_box.variables["QMain"] = GameData.QMain
	for i in range(len(GameData.villagersTalked)):
		dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]
	#Items updating
	#TODO: Add more if needed
	dialogue_box.variables["Twigs"] = GameData.itemDialogue[0]["Value"]
		
	# Get the day for the appropriate dialogue
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
	
	
	
	if Input.is_action_just_pressed("StartDialogue") and enterBody == true:
		if GameData.current_ui != "dialogue" && GameData.current_ui != "":
			return
		if not dialogue_box.running:
			GameData.charLock = true
			GameData.current_ui = "dialogue"
			#Run the loop and check true that we talked to that villager
			# This is for the requirement to leave the Day
			dialogue_box.variables[NPCname] = true
			
			#GameData.QWild = dialogue_box.variables["QWild"]
			
			print(dialogue_box.variables)
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
			
			dialogue_box.start()
			print(dialogue_box)
	elif not dialogue_box.running and enterBody == true:
		GameData.charLock = false
		if GameData.current_ui == "dialogue":
			GameData.current_ui = ""

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




func _on_dialogue_box_dialogue_ended():
	
	#Quest stuff for the Main World
	if (dialogue_box.variables["QMain"] == true):
		GameData.QMain = true
	pass # Replace with function body.
	
	
func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	if $FixedDialoguePosition/DialogueBox.speaker.text != "":
		var idx = Utils.char_dict[str($FixedDialoguePosition/DialogueBox.speaker.text)]
		$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
