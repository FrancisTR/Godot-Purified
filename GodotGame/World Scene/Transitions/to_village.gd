extends StaticBody2D

@onready var dialogue_box = $Dialogue/Dialogue/DialogueBox



var dialogue_voices = [
	# Days 1 (Complete)
	{	
		"Rano": [
			{"Name": "LL", "Start": "1:13.5", "End": "1:17", "Emotion": ""},
		],
		"ChildrenDone": [
			{"Name": "LL", "Start": "1:19.8", "End": "1:23.8", "Emotion": "Surprised"},
			{"Name": "LL", "Start": "0:26.8", "End": "0:31.5", "Emotion": "Anger"},
			{"Name": "Croak", "Start": "0:33", "End": "0:34.8", "Emotion": "Happy"},
			{"Name": "LL", "Start": "1:25.3", "End": "1:30.5", "Emotion": "Happy"},
		],
	},
	
	# Days 2 (Complete)
	{	
		"Rano": [
			{"Name": "LL", "Start": "1:13.5", "End": "1:17", "Emotion": ""},
		],
		"ChildrenDone": [
			{"Name": "LL", "Start": "0:09", "End": "0:11", "Emotion": "Surprised"},
			{"Name": "Main", "Start": "03:37.27", "End": "03:42.10", "Emotion": "Happy"},
			{"Name": "LL", "Start": "2:45.4", "End": "0:168.713317871094", "Emotion": ""},
			
			{"Name": "LL", "Start": "1:43", "End": "1:48.15", "Emotion": "Happy"},
			{"Name": "LL", "Start": "1:48.19", "End": "1:52.14", "Emotion": "Happy"},
			{"Name": "LL", "Start": "1:52.23", "End": "1:54.29", "Emotion": "Happy"},
		],
	},
	
	# Days 3 (Complete)
	{	
		"Rano": [
			{"Name": "LL", "Start": "1:13.5", "End": "1:17", "Emotion": ""},
		],
		"ChildrenDone": [
			{"Name": "LL", "Start": "0:52", "End": "0:54", "Emotion": ""},
			{"Name": "Main", "Start": "04:28.35", "End": "04:35.55", "Emotion": "Happy"},
			{"Name": "LL", "Start": "0:20.1", "End": "0:21", "Emotion": "Happy"},
			{"Name": "LL", "Start": "0:39.5", "End": "0:41", "Emotion": ""},
			{"Name": "Main", "Start": "04:35.68", "End": "04:38.94", "Emotion": ""},
			
			{"Name": "LL", "Start": "2:14.07", "End": "2:19.09", "Emotion": "Happy"},
			{"Name": "LL", "Start": "2:19.09", "End": "2:22", "Emotion": ""},
		],
	},
	
]

var dialogue_voiceSpecific
var audioList = {
	"Main": "res://Assets/DialogueVoice/MC.mp3",
	"LL": "res://Assets/DialogueVoice/LLE.mp3",
	"Croak": "res://Assets/DialogueVoice/Croak.mp3",
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
	"LL": {
		"Happy": "IMGLINK",
		"Sad": "IMGLINK",
		"Disgust": "IMGLINK",
		"Fear": "IMGLINK",
		"Surprise": "IMGLINK",
		"Anger": "IMGLINK",
	},
	"Croak": {
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

var ranoAP = false








# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not dialogue_box.running:
		GameData.charLock = false
	else:
		$Dialogue/Dialogue/CharacterIMG.visible = true
		
		$Dialogue/Dialogue/Voice.visible = true
	
		



func _on_teleport_body_entered(body):
	if (body.name == "CharacterBody2D"):
		GameData.charLock = true
		#TODO Add more days
		#Show an error dialogue where the player did not craft/find
		if GameData.day >= 4:
			SceneTransition.change_scene("res://World Scene/World.tscn")
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 1):
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				ranoAP = true
				dialogue_box.start("Error")
				
			#dialogue_box.start("Kids")
			#GameData.charLock = true
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 2):
			#dialogue_box.start("Kids2")
			#GameData.charLock = true
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				ranoAP = true
				dialogue_box.start("Error")
				
		elif (GameData.questComplete["Wild"] == false and GameData.inventory_amount.size() != 0 and GameData.day == 3):
			#dialogue_box.start("Kids3")
			#GameData.charLock = true
			GameData.QWild = true
			if (GameData.talkToKid == false):
				TextTransition.set_to_click(
					"When you are about to leave, a group of kids appear and block your path…",
					"res://World Scene/kids_scene.tscn",
					"Click To Continue"
				)
				GameData.talkToKid = true
				SceneTransition.change_scene("res://Globals/text_transition.tscn")
			else:
				ranoAP = true
				dialogue_box.start("Error")
		else:
			#All requirements met
			ranoAP = false
			#TODO: Add more days
			if GameData.questComplete["Wild"] == true and GameData.leaveVillageQuest == false:
				if (GameData.day == 1):
					dialogue_box.start("ChildrenComplete")
				elif (GameData.day == 2):
					dialogue_box.start("ChildrenComplete2")
				elif (GameData.day == 3):
					dialogue_box.start("ChildrenComplete3")
			else:
				SceneTransition.change_scene("res://World Scene/World.tscn")


func _on_dialogue_box_dialogue_proceeded(node_type):
	SoundControl.is_playing_sound("button")
	
	#TODO: Set up the dialogue voices
	SoundControl.dialogue_audio_stop() #Stop the audio if next dialogue
	#print(audioCount)
	print("Dialogue Node: "+str(node_type))
	if str(node_type) == str(1):
		audioCount += 1
	if ranoAP == true:
		print("Rano")
		if (audioCount < len(dialogue_voices[GameData.day - 1]["Rano"])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["Rano"][-1]
	else:
		if (audioCount < len(dialogue_voices[GameData.day - 1]["ChildrenDone"])):
			print("Audio Count: "+str(audioCount))
			dialogue_voiceSpecific = dialogue_voices[GameData.day - 1]["ChildrenDone"][audioCount]
	
	
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
		
		#var CharacterVoice = audioList[dialogue_voiceSpecific["Emotion"]]
		#if (audioList[dialogue_voiceSpecific["Emotion"]] == ""):
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		#else: #Emotion
			#$FixedDialoguePosition/CharacterIMG.texture = Utils.character_list.characters[idx].image
		$Dialogue/Dialogue/CharacterIMG.texture = Utils.character_list.characters[idx].image



func _on_voice_pressed():
	print("Play Audio")
	var CharacterVoice = audioList[dialogue_voiceSpecific["Name"]]
	##TODO: PLay audio
	SoundControl.play_audio(CharacterVoice, dialogue_voiceSpecific["Start"], dialogue_voiceSpecific["End"]) # Node, string, int, int
	dialogue_box.show_options()


func _on_dialogue_box_dialogue_ended():
	audioCount = -1 #Reset audio index
	$Dialogue/Dialogue/Voice.visible = false
	$Dialogue/Dialogue/CharacterIMG.visible = false


func _on_dialogue_box_dialogue_signal(value):
	if value == "Leave":
		GameData.leaveVillageQuest = true
		SceneTransition.change_scene("res://World Scene/World.tscn")
