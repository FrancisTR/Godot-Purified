extends Area2D

@onready var dialogue_box = $FixedDialoguePosition/DialogueBox

var enterBody = false

var NPCname = null

func _ready():
	NPCname = null
	set_process_input(true)
	

# TODO: Map more ID's for dialogue for more days
func _process(delta):
	#Set the variables of the people that already talked to
	#This prevents a reset if the player visited the wilderness and comes back
	for i in range(len(GameData.villagersTalked)):
		dialogue_box.variables[GameData.villagersTalked[i]["Name"]] = GameData.villagersTalked[i]["Talked"]
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
		if not dialogue_box.running:
			GameData.charLock = true
			
			#Run the loop and check true that we talked to that villager
			# This is for the requirement to leave the Day
			dialogue_box.variables[NPCname] = true
			print(dialogue_box.variables)
			for i in range(len(GameData.villagersTalked)):
				if GameData.villagersTalked[i]["Name"] == NPCname:
					GameData.villagersTalked[i]["Talked"] = true
			
			dialogue_box.start()
			print(dialogue_box)
	elif not dialogue_box.running and enterBody == true:
			GameData.charLock = false

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
		NPCname = null
		if dialogue_box.running:
			GameData.charLock = false
			dialogue_box.stop()
		dialogue_box.start_id = ""
