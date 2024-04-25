extends Control

@onready var dialogue_box = $Dialogue/DialogueBox

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO Add more days?
	if not dialogue_box.running:
		if GameData.day == 1:
			dialogue_box.start("Children")
		elif GameData.day == 2:
			dialogue_box.start("Children2")
		elif GameData.day == 3:
			dialogue_box.start("Children3")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#TODO: Add theme?
func _process(delta):
	#Appear the game username in dialogue (Only Appears in NPC interaction)
	Utils.character_list.characters[0].name = GameData.username
	if dialogue_box.running:
		if ($Dialogue/DialogueBox.speaker.text == GameData.username):
			$CharacterIMG.texture = Utils.character_list.characters[0].image
	#SoundControl.is_playing_theme("afternoon")


func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO Stop audio once we continue
	
	SoundControl.is_playing_sound("button")
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($Dialogue/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
		$CharacterIMG.texture = Utils.character_list.characters[idx].image


func _on_voice_pressed():
	print("Play Audio")


func _on_dialogue_box_dialogue_ended():
	$Dialogue/Voice.visible = false
	$CharacterIMG.visible = false
	$ShowItemRequest.visible = false
	#Go to wilderness
	SceneTransition.change_scene("res://World Scene/Wilderness.tscn")


func _on_dialogue_box_dialogue_signal(value):
	if value == "Item":
		#TODO: Add more item to show?
		if GameData.day == 1:
			$ShowItemRequest.texture = load("res://Assets/Custom/Items/WaterBottleSpecial.png")
		elif GameData.day == 2:
			$ShowItemRequest.texture = load("res://Assets/Custom/CraftingTable.png")
		$ShowItemRequest.visible = true
	else:
		$ShowItemRequest.visible = false
