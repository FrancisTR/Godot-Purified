extends Control

@onready var dialogue_box = $Dialogue/DialogueBox
@onready var dialogue_idx = 0 #For printing out the dialogue sound

var text = load("res://Dialogues/CharacterList.tres")

#TODO SplitAudio
var dialogue_voices = [
	# Tutorial
	{
		"Tutorial": [
			{"Name": "Talia", "Start": "0:00", "End": "0:28.8", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""}, #Confirm Name
			
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""}, #Confirmed name, show town
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""}, #Rename
			
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""}, #Yes or no
			#no
			{"Name": "Talia", "Start": "0:31", "End": "0:53.6", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			
			#Training time
			{"Name": "Talia", "Start": "0:55.2", "End": "0:59", "Emotion": ""},
		]
	},
	
	# Tutorial 2
	{
		"Tutorial2": [
			{"Name": "Talia", "Start": "0:59", "End": "1:01", "Emotion": ""},
			{"Name": "Talia", "Start": "1:02.5", "End": "1:04.2", "Emotion": ""},
			{"Name": "Talia", "Start": "1:05.7", "End": "1:09.2", "Emotion": ""},
			
			#End of training
			{"Name": "Talia", "Start": "1:14.4", "End": "1:19", "Emotion": ""},
			
			
			#End Idx of getting me that rock again if player has no rock
			{"Name": "Talia", "Start": "1:11.1", "End": "1:13", "Emotion": ""},
		]
	},
	
	# Talia 7
	{
		"Talia7": [
			{"Name": "Main", "Start": "07:44.25", "End": "07:46.12", "Emotion": ""},
			{"Name": "Talia", "Start": "1:19.6", "End": "1:27", "Emotion": ""},
			
			#Truth
			{"Name": "Main", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			#Lie
			{"Name": "Main", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
			{"Name": "Talia", "Start": "", "End": "", "Emotion": ""},
		]
	},
	
]






var dialogue_voiceSpecific
var audioList = {
	"Main": "res://Assets/DialogueVoice/MC.mp3",
	"Talia": "res://Assets/DialogueVoice/Tutorial Talia.mp3",
}

var emotionList = {
	"Main": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Talia": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
}
var load_audio
var audioCount = -1











# Called when the node enters the scene tree for the first time.
func _ready():
	
	dialogue_box.variables["Player"] = GameData.username
	$Name/RichTextLabel.text = GameData.username
	
	dialogue_box.dialogue_data = load("res://Dialogues/Tutorial.tres")
	if (not dialogue_box.running):
		if GameData.username == "":
			dialogue_box.start_id = "Tutorial"
			dialogue_box.start()
		elif GameData.day == 7:
			dialogue_box.dialogue_data = load("res://Dialogues/Dialogue.tres")
			dialogue_box.start_id = "Talia7"
			dialogue_box.start()
		elif (GameData.username != ""):
			dialogue_box.start_id = "Tutorial2"
			dialogue_box.start()




#var testDic = {"Talia": 2}
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if GameData.day <= 2:
			SoundControl.is_playing_theme("afternoon")
	elif GameData.day >= 3:
		SoundControl.is_playing_theme("main")
	
	#Dynamically change keys based on settings
	#Interaction
	#Inventory
	#Options
	dialogue_box.variables["Interaction"] = $Controls/RemapContainer/InteractionButton.text.replace("*", "")
	dialogue_box.variables["Inventory"] = $Controls/RemapContainer/InventoryButton.text.replace("*", "")
	dialogue_box.variables["Options"] = $Controls/RemapContainer/BackButton.text.replace("*", "")
	pass




func _on_dialogue_box_dialogue_signal(value):
	
	#TODO: More values will be added based on dialogue direction
	if (value == "EnterName"):
		dialogue_box.stop()
		get_tree().change_scene_to_file("res://Main Menu Scene/EnterName.tscn")
	
	elif (value == "ShowControls"):
		$Controls.visible = true
		
	elif (value == "ShowName"):
		$Name.visible = true
		
	elif (value == "Marks"):
		$Marks.visible = true
	
	elif (value == "Town"):
		$Map.visible = true
		
	
	elif (value == "Done"):
		TextTransition.set_to_click(
			"You then follow Talia outside.",
			"res://Main Menu Scene/tutorial_2.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	else:
		$Controls.visible = false
		$Name.visible = false
		$Map.visible = false
		$Marks.visible = false




func _on_dialogue_box_dialogue_proceeded(node_type):
	#print($Dialogue/DialogueBox.speaker.text," addf")
	
	#TODO: Set up the dialogue voices
	SoundControl.dialogue_audio_stop() #Stop the audio if next dialogue
	#print(audioCount)
	print("Dialogue Node: "+str(node_type))
	if str(node_type) == str(1):
		audioCount += 1
	if dialogue_box.start_id == "Tutorial":
		if (audioCount < len(dialogue_voices[GameData.day - 1]["Tutorial"])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["Tutorial"][audioCount]
	
	if dialogue_box.start_id == "Tutorial2":
		if (audioCount < len(dialogue_voices[GameData.day - 1]["Tutorial2"])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["Tutorial2"][audioCount]
	
	if dialogue_box.start_id == "Talia7":
		if (audioCount < len(dialogue_voices[GameData.day - 1]["Talia7"])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["Talia7"][audioCount]
	
	#TODO Stop audio once we continue
	dialogue_box.custom_effects[0].skip = true
	dialogue_box.show_options()
	
	SoundControl.is_playing_sound("button")
	if $Dialogue/DialogueBox.speaker.text != "":
		var idx
		if Utils.char_dict.keys().find(str($Dialogue/DialogueBox.speaker.text)) != -1:
			idx = Utils.char_dict[str($Dialogue/DialogueBox.speaker.text)]
		else:
			#Its the main character
			idx = Utils.char_dict["Main"]
		#var CharacterVoice = audioList[dialogue_voiceSpecific["Emotion"]]
		#if (audioList[dialogue_voiceSpecific["Emotion"]] == ""):
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		#else: #Emotion
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		$CharacterIMG.texture = Utils.character_list.characters[idx].image



func _on_voice_pressed():
	print("Play Audio")
	var CharacterVoice = audioList[dialogue_voiceSpecific["Name"]]
	##TODO: PLay audio
	SoundControl.play_audio(CharacterVoice, dialogue_voiceSpecific["Start"], dialogue_voiceSpecific["End"]) # Node, string, int, int
	dialogue_box.show_options()
	pass # Replace with function body.


func _on_dialogue_box_dialogue_ended():
	audioCount = -1 #Reset audio index
	$Dialogue/Voice.visible = false
	$CharacterIMG.visible = false
	if GameData.day == 7:
		GameData.visitTutorial = false
		TextTransition.set_to_click(
			"You then enter the village...",
			"res://World Scene/World.tscn",
			"Click To Continue"
		)
		SceneTransition.change_scene("res://Globals/text_transition.tscn")
	pass # Replace with function body.
