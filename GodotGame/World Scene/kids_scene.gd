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
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#SoundControl.is_playing_theme("afternoon")
	pass


func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	#TODO Stop audio once we continue
	
	SoundControl.is_playing_sound("button")
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		$CharacterIMG.texture = Utils.character_list.characters[idx].image



func _on_voice_pressed():
	print("Play Audio")
	pass # Replace with function body.


func _on_dialogue_box_dialogue_ended():
	$Dialogue/Voice.visible = false
	$CharacterIMG.visible = false
	#Go to wilderness
	SceneTransition.change_scene("res://World Scene/Wilderness.tscn")
