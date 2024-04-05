extends Control

@onready var dialogue_box = $Dialogue/DialogueBox

var text = load("res://Dialogues/CharacterList.tres")
# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue_box.variables["Player"] = GameData.username
	if (not dialogue_box.running):
		if GameData.username == "":
			dialogue_box.start()
		else:
			dialogue_box.start_id = "Tutorial2"
			dialogue_box.start()
	pass


#var testDic = {"Talia": 2}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(dialogue_box.sample_portrait)
	#var temp_index = testDic[str(text.characters[1].name)]
	#$Character.texture = text.characters[temp_index].image
	#print(text.characters[1].image)
	pass


func _on_dialogue_box_dialogue_signal(value):
	
	#TODO: More values will be added based on dialogue direction
	if (value == "EnterName"):
		dialogue_box.stop()
		get_tree().change_scene_to_file("res://Main Menu Scene/EnterName.tscn")
	
	elif (value == "ShowControls"):
		$Controls.visible = true
		
	elif (value == "DialogueControl"):
		$NPCexample.visible = true
		
	elif (value == "Done"):
		GameData.visitTutorial = true
		get_tree().change_scene_to_file("res://World Scene/World.tscn")
	else:
		$Controls.visible = false
		$NPCexample.visible = false
	pass # Replace with function body.

func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		$CharacterIMG.texture = Utils.character_list.characters[idx].image
